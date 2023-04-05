Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F306D7844
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Apr 2023 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjDEJ35 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Apr 2023 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbjDEJ3g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Apr 2023 05:29:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B55590
        for <linux-pwm@vger.kernel.org>; Wed,  5 Apr 2023 02:29:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso6680349wms.5
        for <linux-pwm@vger.kernel.org>; Wed, 05 Apr 2023 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680686939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Kvyw5dfxPzoo5ahaTvmbkIzP92SGsSe2Eci+KOZOgQ=;
        b=wF1lWf2eN0nUHCgOcCLxBDuhW1WkQrs+62puD9WNVvY7Mo5D8pOZ2TSkvQCKKu167b
         D78Tc6I4UMR+qRZjENNm8ZR63xBDJ+9INVtOyo4CZP3h7ac498k/2p3iMoBEK3GscOAy
         MbjgEqn4YM0vHTtG3S1Ejkf6lOVdHZ7NgRt05J+IKT9DmaGVG8zk1HxqXRCaT5bBvQ2d
         b0ih3yx8sTfwHtEX4FncfqTCvdwAWmwRJYrTAr7tM4OR55XoP30oTy2YGWIQN3kPszTA
         aH7q20+uxSFTB4onIndCPhYM6upwYP6t8ESJL5xAtE63OOtYmm5r8CiJIU6V+ojKYOYU
         FgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kvyw5dfxPzoo5ahaTvmbkIzP92SGsSe2Eci+KOZOgQ=;
        b=j+c2SU8ywHFyFthI4s9/IA85C8KSmhS5GRO+Iz53exZ0E1CBXo6fFl8fy0WZuFxTkP
         P1NMRmhAY+2LPPi4fW/xO0mxC5gQBZOqoPoSVPjcAc/G65jDW+qS8wEgDRvZ/XxWgjBH
         TNB2hH7qz2T3UGa9JNbsnXhi3ptun5Bl7VmZfFFO1m3gorvlgEBRH902fhFA1Z6+0kuH
         3agY1vezGFlHAyPmTzyHZGAxFeeU8mvtpAl3rAx8ownZAP2QxSUERt18sD6t2ZY2QNdK
         jtfNnQLE5oEFAXZUDnrcUDKtZc83QAUU9wEXO/km0/G+sqrGRTR7LPRt2pq7Hq9z7xwJ
         I8Gg==
X-Gm-Message-State: AAQBX9cLCvGEG2krqBb9cjXnYEJ1aQZqJQXShj1ixuQuHc2woZcdeD8m
        W89CD+sL+ZDbaQJtUaj4drIR9UoZvRgRsd7L8r0=
X-Google-Smtp-Source: AKy350aDTMdjfvThV2Vky13AG+hkacl/fNweYYwzs5gGLiaI7bwyGGJPmWR2lBZvoBxleaHAB1fyzw==
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr4113162wmq.29.1680686939585;
        Wed, 05 Apr 2023 02:28:59 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003ee42696acesm1581457wmj.16.2023.04.05.02.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:28:59 -0700 (PDT)
Message-ID: <61c93793-1586-bba0-0f9d-f028d5d636b9@baylibre.com>
Date:   Wed, 5 Apr 2023 11:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND 2/2] pwm: mtk-disp: Configure double buffering
 before reading in .get_state()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, wenst@chromium.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20230403133054.319070-1-angelogioacchino.delregno@collabora.com>
 <20230403133054.319070-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230403133054.319070-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/04/2023 15:30, AngeloGioacchino Del Regno wrote:
> The DISP_PWM controller's default behavior is to always use register
> double buffering: all reads/writes are then performed on shadow
> registers instead of working registers and this becomes an issue
> in case our chosen configuration in Linux is different from the
> default (or from the one that was pre-applied by the bootloader).
> 
> An example of broken behavior is when the controller is configured
> to use shadow registers, but this driver wants to configure it
> otherwise: what happens is that the .get_state() callback is called
> right after registering the pwmchip and checks whether the PWM is
> enabled by reading the DISP_PWM_EN register;
> At this point, if shadow registers are enabled but their content
> was not committed before booting Linux, we are *not* reading the
> current PWM enablement status, leading to the kernel knowing that
> the hardware is actually enabled when, in reality, it's not.
> 
> The aforementioned issue emerged since this driver was fixed with
> commit 0b5ef3429d8f ("pwm: mtk-disp: Fix the parameters calculated
> by the enabled flag of disp_pwm") making it to read the enablement
> status from the right register.
> 
> Configure the controller in the .get_state() callback to avoid
> this desync issue and get the backlight properly working again.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/pwm/pwm-mtk-disp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 82b430d881a2..fe9593f968ee 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -196,6 +196,16 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
>   		return err;
>   	}
>   
> +	/*
> +	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
> +	 * registers double buffer and manual commit to working register before
> +	 * performing any read/write operation
> +	 */
> +	if (mdp->data->bls_debug)
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +
>   	rate = clk_get_rate(mdp->clk_main);
>   	con0 = readl(mdp->base + mdp->data->con0);
>   	con1 = readl(mdp->base + mdp->data->con1);

Hi,

Same test.
Looks fine.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alex
