Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F610113D2B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLEIiD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 03:38:03 -0500
Received: from mx01-fr.bfs.de ([193.174.231.67]:56100 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfLEIiD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Dec 2019 03:38:03 -0500
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 7782D202F1;
        Thu,  5 Dec 2019 09:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1575535076; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N89mIBhLkn3llR08ackf1tw/9b9UA+6X9J+YpdHprTc=;
        b=xVw37OiWCXFKBfYcm4cpaqktWxfdbvvR7mHMQgsRfDYECj3xkiWCbVAiBWI8JnJWvyAcUz
        zOKOvQyRElw14l6T/T8THSq9CLDo9jAbNYjMsdKMTmHR6ZVtNsxZMAJFtmV8Vg6ZjqoKZQ
        TrFeztpQBefHWudZYnvGC4I2b2z7ylccPugaMU9aAWWFxAcA/+xnWNbKGJSgagwSYUoe+M
        zzU6fp3UIhn2RJoHQCAyOiQxaANMCtJ5Vy0TkgzgHdoRxkUs2VtKeKYfLDl9CYazklEqmV
        rPigI2Of/Fh3nRfKon5hR+ki0IQtf1YmMNWB4PO3YQRmY2NiGGdZmqV6qLwzqw==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 1EDBABEEBD;
        Thu,  5 Dec 2019 09:37:56 +0100 (CET)
Message-ID: <5DE8C1E3.4080204@bfs.de>
Date:   Thu, 05 Dec 2019 09:37:55 +0100
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] pwm: sun4i: Narrow scope of local variable
References: <20191002101624.gljyf7g4nia2rcbx@pengutronix.de> <20191205072404.6858-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191205072404.6858-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.07
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.07 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-2.97)[99.88%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Am 05.12.2019 08:24, schrieb Uwe Kleine-König:
> The variable pval is only used in a single block in the function
> sun4i_pwm_calculate(). So declare it in a more local scope to simplify
> the function for humans and compilers.
> 
> While the diffstat for this patch is negative for this patch I still
> thing the advantage of having a narrower scope is beneficial.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> for the patch that became
> 
> 	1b98ad3b3be9 ("pwm: sun4i: Drop redundant assignment to variable pval")
> 
> (and which yielded the situation that pval is only used in this single
> block) I suggested to do this change. This was ignored however by both
> Colin and Thierry without comment. So I suggest the change here
> separately.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/pwm-sun4i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 581d23287333..8919e6ab7577 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -149,7 +149,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
>  			       u32 *dty, u32 *prd, unsigned int *prsclr)
>  {
>  	u64 clk_rate, div = 0;
> -	unsigned int pval, prescaler = 0;
> +	unsigned int prescaler = 0;
>  
>  	clk_rate = clk_get_rate(sun4i_pwm->clk);
>  
> @@ -170,6 +170,8 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
>  	if (prescaler == 0) {
>  		/* Go up from the first divider */
>  		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
> +			unsigned int pval;
> +
>  			if (!prescaler_table[prescaler])
>  				continue;
>  			pval = prescaler_table[prescaler];


nit picking:
Doing the assignment first would remove the only use
of prescaler_table[prescaler].

unsigned int pval = prescaler_table[prescaler];
if ( ! pval )
  continue;

if you feel adventures you could also replace the for() for a while()
since we know that prescaler == 0.

while ( prescaler < PWM_PRESCAL_MASK )
{
unsigned int pval = prescaler_table[prescaler++];
....


jm2c,

 wh
