Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429DAC899B
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfJBN36 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 09:29:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBN36 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 09:29:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92DSx1F037156;
        Wed, 2 Oct 2019 13:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EM3e9nI3amV6xVGJaxjxz45i18U04uaHvQ94gCdzIIs=;
 b=c+Mg75kVq8y09t0ZUPlttkci0ZJew3k1BY8yYl6R2HwYdCKfYoLmY9l1reOE9bz5Iwmk
 9qHxc3IYdyJXJOQi9GLggW1mULgFeIwMYInD1cpLYUS+HlyIe7FAIIYhRLErr8hiGs4h
 z3Apaqb/sayWPcMzdwAClBeDI6QlANcXRInSK2MIWsDctDHdekyY2ZiosW9Yp9A1akI0
 QhwsYMEdxpau7JeQqxYWsKyeigNoYCHv/u18pjMFZJaXxa95L+W4a1M9c4fOBD4WG8IS
 JCXENDAt3XgmB3iA7+dTaeup3n+lvZUdsYHnNOiRjItp0Kbp3YNVSIvdH2qkMrzSlgSf lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05rvuf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 13:29:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92DSlsc098366;
        Wed, 2 Oct 2019 13:29:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vckynx97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 13:29:43 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92DThq4028591;
        Wed, 2 Oct 2019 13:29:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 06:29:42 -0700
Date:   Wed, 2 Oct 2019 16:29:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: redundant assignment to variable pval
Message-ID: <20191002132933.GO29696@kadam>
References: <20191002100844.10490-1-colin.king@canonical.com>
 <20191002132506.GO22609@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002132506.GO22609@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020129
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 02, 2019 at 04:25:06PM +0300, Dan Carpenter wrote:
> On Wed, Oct 02, 2019 at 11:08:44AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Variable pval is being assigned a value that is never read. The
> > assignment is redundant and hence can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..53970d4ba695 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -156,7 +156,6 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
> >  	if (sun4i_pwm->data->has_prescaler_bypass) {
> >  		/* First, test without any prescaler when available */
> >  		prescaler = PWM_PRESCAL_MASK;
> > -		pval = 1;
> >  		/*
> >  		 * When not using any prescaler, the clock period in nanoseconds
> >  		 * is not an integer so round it half up instead of
> 
> Are you sure?  It looks used to me.

Ah.  Never mind.  My tree was out of date.

regards,
dan carpenter

