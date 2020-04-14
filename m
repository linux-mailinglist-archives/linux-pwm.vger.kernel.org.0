Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABE1A8A30
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504429AbgDNSuF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 14:50:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44224 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504407AbgDNStx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 14:49:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EIeAUR125070;
        Tue, 14 Apr 2020 18:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=q4qne1W5zGbbsc7dFpIdBBMnXKX3IuZywtcs1GLXfAk=;
 b=AEUBmdw5FvchfI0MAffJp5KIT5P8nawjMtj2+vu0SSs2fyMVNPkQKhs+9E2nvpcygU9d
 eJPWCPoP4EEtZ/Xm8zRIhmOCeiqhX5GrfR4Y8cIwgoF+Z7C+Wfky70YmUBDdtNnWRfzN
 mLKOB+OF7VoHYojZEdjeCuhEAAb74n4AJQE/tWtJkZBYxxKGVcW29q+uosslRPh6no7L
 lWRgeC4fYHVg//FEnvHkwHXtkpPBBkjTa3HdMFJSZ/wMUoqF59sHjH3Dh/N9x6o+A8GV
 tmssRsqcYhSS3dUkf71nDK4vEfucSbVeRC3k93ye47JRQT0wgiysZSmefCCVZRJlu4QF jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30b5um6q6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:49:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EIc7PK008702;
        Tue, 14 Apr 2020 18:49:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqphh50g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:49:35 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EInXgC004751;
        Tue, 14 Apr 2020 18:49:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 11:49:32 -0700
Date:   Tue, 14 Apr 2020 21:49:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net,
        Joe Perches <joe@perches.com>, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Message-ID: <20200414184925.GA12862@kadam>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
 <20200414135827.GB3593749@ulmo>
 <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=864 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=939 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140132
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Huh...

If you look at dev_vprintk_emit().  It looks like if
create_syslog_header() returns a string then vprintk_store() will add
a newline.

I guess that means that dev_printk() can't be used to pr_cont().  And
probably that's deliberate because using pr_cont() after boot is racy
anyway.

regards,
dan carpenter

