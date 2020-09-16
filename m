Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDE26BA21
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 04:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIPC2g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 22:28:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgIPC2C (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B3D2119396917439775;
        Wed, 16 Sep 2020 10:27:59 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:52 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] pwm: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:28 +0800
Message-ID: <20200916025028.3992887-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pwm/core.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 276e939a5684..1f16f5365d3c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1327,30 +1327,19 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static const struct seq_operations pwm_seq_ops = {
+static const struct seq_operations pwm_debugfs_sops = {
 	.start = pwm_seq_start,
 	.next = pwm_seq_next,
 	.stop = pwm_seq_stop,
 	.show = pwm_seq_show,
 };
 
-static int pwm_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &pwm_seq_ops);
-}
-
-static const struct file_operations pwm_debugfs_ops = {
-	.owner = THIS_MODULE,
-	.open = pwm_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_debugfs_init(void)
 {
 	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL,
-			    &pwm_debugfs_ops);
+			    &pwm_debugfs_fops);
 
 	return 0;
 }
-- 
2.25.1

