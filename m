Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1A2C7243
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Nov 2020 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgK1VuW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 28 Nov 2020 16:50:22 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:59642 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387701AbgK1UYM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 28 Nov 2020 15:24:12 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 9515D1AB018
        for <linux-pwm@vger.kernel.org>; Sat, 28 Nov 2020 13:23:29 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id j6kjkG4nkwNNlj6kjkSb0M; Sat, 28 Nov 2020 13:23:29 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=cqm1bWwi c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=BTeA3XvPAAAA:8
 a=8Irnj8bMnQPBBtp7gFEA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=tafbbOV3vt1XuEhzTjGK:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B5TOMW+1RDo4EDUmClChLTL8dkNLROgGaLYCGrQoGVc=; b=GnWhFomQxR1MY2QQ6kMhfOR0Y4
        3AWe8on+cV9ZPIrrhsiu0LVIrYPKd4YyiWrymtwR1jhobFRBjXxz7dlU+oLmGBm4yfMZa2k9IMqCx
        +zMR6Vx/6aMz5/5CGZ43gLzf1EqU7O2bNl8RoKQEv+ZCUDKsQ6K53zA4KfCaTeiC1xo3mRy0vSZEB
        QLxzVFOkY1woQccVloe/jaXV2Xza+bL4LANf6sm09IFJKFqkHphhxhsZMyFn6BVZVp74CLunLEJJu
        t7J7LbQ3fqqJNPAsEECLhDNXCW7G+dzullEBpb7ZUdfjSwGZjQGcFh2zKIEFYiH8ePXmDNEmf+PGJ
        jVY4q02A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48430 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kj6kh-002AVk-OV; Sat, 28 Nov 2020 20:23:27 +0000
Date:   Sat, 28 Nov 2020 12:23:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pwm-fan): Switch to using the new API
 kobj_to_dev()
Message-ID: <20201128202327.GA89108@roeck-us.net>
References: <1606525206-22154-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606525206-22154-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kj6kh-002AVk-OV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:48430
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Nov 28, 2020 at 09:00:06AM +0800, Tian Tao wrote:
> fixed the following coccicheck:
> drivers/hwmon//pwm-fan.c:152:60-61: WARNING opportunity for kobj_to_dev().
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

With the switch to use devm_hwmon_device_register_with_info() instead of
devm_hwmon_device_register_with_groups(), this patch is no longer necessary.
Please see tip of hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 1f63807..7849011 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -149,7 +149,7 @@ static struct attribute *pwm_fan_attrs[] = {
>  static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
>  				     int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  
>  	/* Hide fan_input in case no interrupt is available  */
