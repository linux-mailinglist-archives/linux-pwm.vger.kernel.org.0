Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0C3B837D
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhF3Ntq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 09:49:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21038 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235039AbhF3Ntp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 09:49:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UDgnuw001791;
        Wed, 30 Jun 2021 13:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=z+LDutZH0urZ87b+8AQ/NNjQzIHfjBaCRTM6UUAttgU=;
 b=okChKBybudDzRdcGK6YQVHExedY1tyJyq7Mn/aRg445Q4pzCamhmmavmAedSWKGzqxaF
 9TllbC7seVM0eLIodVBQ1KIG9xdm4SNtOAZ7LsVro9jJJAy+zgECmF0LYLnOsTj0LR2c
 CtNTNa8dOxNKVP4rSX3d9Czu8IrEpSGNtyfM+S21tkKLucPz1bToqgyVCVAaJoDXxBle
 JzbTm2mq363zxIaw5EUfCV08OtM5zpWPJUiBneSw90jaNZ/hbpv5ui1RjBjLLTeMiStU
 lOOJoKNdYZRH/mO77AyccHMIkGpa3lyIPysXAVEx8fo1RZS6iXweOwNGy8MBS2KuHMO/ HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq1254-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:47:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UDe59C071080;
        Wed, 30 Jun 2021 13:47:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 39dt9h4jx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:47:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15UDl5Mm100976;
        Wed, 30 Jun 2021 13:47:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 39dt9h4jwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:47:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15UDl4Vm024783;
        Wed, 30 Jun 2021 13:47:04 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 06:47:03 -0700
Date:   Wed, 30 Jun 2021 16:46:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] pwm: ep93xx: Fix uninitialized variable bug in
 ep93xx_pwm_apply()
Message-ID: <YNx1y8PlSLehZVIY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: jnggKSkJ1roDwESKAcPbsCmeJqVJyvbP
X-Proofpoint-GUID: jnggKSkJ1roDwESKAcPbsCmeJqVJyvbP
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Smatch found a potential uninitialized variable in ep93xx_pwm_apply():

    drivers/pwm/pwm-ep93xx.c:147 ep93xx_pwm_apply()
    error: uninitialized symbol 'ret'.

Initialize "ret" to zero at the start to solve this issue.

Fixes: f6ef94edf0f6 ("pwm: ep93xx: Unfold legacy callbacks into ep93xx_pwm_apply()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pwm/pwm-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 70fa2957f9d3..ffa79248c1e1 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -61,7 +61,7 @@ static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
-	int ret;
+	int ret = 0;
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	bool enabled = state->enabled;
 
-- 
2.30.2

