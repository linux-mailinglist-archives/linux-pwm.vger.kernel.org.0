Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195CF3A2D41
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jun 2021 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJNnS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Jun 2021 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNnS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jun 2021 09:43:18 -0400
Received: from pmg01-out1.zxcs.nl (pmg01-out1.zxcs.nl [IPv6:2a06:2ec0:1::ffeb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBFC061574
        for <linux-pwm@vger.kernel.org>; Thu, 10 Jun 2021 06:41:21 -0700 (PDT)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (ZXCS) with ESMTP id F258510562D;
        Thu, 10 Jun 2021 15:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J7BYOV3zpefWkAu9B9rGYhAKW1ymqNGvJk9qXTZ3fm8=; b=Fnj3Kf6oQ6udqaTrf2rT63ksli
        UFtUc05M59I8CpolR6SbTloiYykr1KmVxfkBTEQ0KksfyqsQhQh2rPXOg8uRe9HgU2MbUdfE7RX43
        OhzPL8J3azkjyQtOY7DeiwVLp9QQnhvRVMj2pguz1wXFE5PH1aMaJraDwPdDKYfhzHd6R8IGErevx
        6TQdYdta2OYTdKRViZm1o6ewnZHFw08UgqPH/VxoFIaG8Ih306NkmQ4BdyoNPD7QRd+nEDjHW6kGb
        wxNqnl0SCjugcnwzVVuGhJfBQbG4kPzTbrZNq7xQ0fnDhRaAAM2rF4AVHr3bII4sS7ngUYmnVdQal
        1DdEpEaQ==;
MIME-Version: 1.0
Date:   Thu, 10 Jun 2021 15:41:15 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 6/6] pwm: sun4i: don't delay if the PWM is already off
In-Reply-To: <20210531044608.1006024-7-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
 <20210531044608.1006024-7-roman.beranek@prusa3d.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f590094496dfbb711e363c36e8573687@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Forwarded-For: roman.beranek@prusa3d.cz
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-05-31 06:46, Roman Beranek wrote:
> Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6ab06b9749d0..88bd90498d1f 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -304,7 +304,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>  
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  
> -	if (state->enabled) {
> +	if (state->enabled || !cstate.enabled) {
>  		mutex_unlock(&sun4i_pwm->ctrl_lock);
>  		return 0;
>  	}

Btw, this now leaves the gate open if the controller is currently
disabled and we are only changing the period register and staying
disabled. This becomes an issue because we always expect the gate to be
disabled when the controller is disabled.

Regards,
Pascal

