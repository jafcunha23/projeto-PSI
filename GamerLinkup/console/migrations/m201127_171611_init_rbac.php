<?php

use yii\db\Migration;

/**
 * Class m201127_171611_init_rbac
 */
class m201127_171611_init_rbac extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        $auth = Yii::$app->authManager;

        // add "createForm" permission
        $createForm = $auth->createPermission('createForm');
        $createForm->description = 'Create form';
        $auth->add($createForm);

        // add "updateForm" permission
        $updateForm = $auth->createPermission('updateForm');
        $updateForm->description = 'Update form';
        $auth->add($updateForm);

        // add "deleteForm" permission
        $deleteForm = $auth->createPermission('deleteForm');
        $deleteForm->description = 'Delete form';
        $auth->add($deleteForm);

        // add "user" role and give this role the "createPost" permission
        $user = $auth->createRole('user');
        $auth->add($user);
        $auth->addChild($user, $createForm);
        $auth->addChild($user, $updateForm);
        $auth->addChild($user, $deleteForm);

        // add "admin" role and give this role the "updateForm" permission
        // as well as the permissions of the "user" role
        $admin = $auth->createRole('admin');
        $auth->add($admin);
        $auth->addChild($admin, $user);

        // Assign roles to users. 1 and 2 are IDs returned by IdentityInterface::getId()
        // usually implemented in your User model.
        $auth->assign($user, 2);
        $auth->assign($admin, 1);
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        echo "m201127_171611_init_rbac cannot be reverted.\n";

        $auth = Yii::$app->authManager;

        $auth->removeAll();

        return false;
    }

    /*
    // Use up()/down() to run migration code without a transaction.
    public function up()
    {

    }

    public function down()
    {
        echo "m201127_171611_init_rbac cannot be reverted.\n";

        return false;
    }
    */
}
