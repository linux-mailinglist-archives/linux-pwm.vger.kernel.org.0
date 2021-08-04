Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7565F3E0661
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Aug 2021 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbhHDRNA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Aug 2021 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhHDRM7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Aug 2021 13:12:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0423C0613D5;
        Wed,  4 Aug 2021 10:12:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so3066345wrr.2;
        Wed, 04 Aug 2021 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqLm8EfM5SnlCMGedDjfLb4X4DuYoCJtVPMlQgV2X1o=;
        b=sCWLSZhPyyln0hjThAJeHOhOHy8a6RC00Bq/oMZe5m93kzlDcsrqg/G4H92gS3D97B
         T/PsmF5I3atptlop4Wm26nhRqEAywJlyjKVN+TMzzq6v7eMn6LfrcUwQ+T9VoJBc4eWE
         q/+Xgig6ssBx/KqllcgCCOEjkvAgda6IzYengQqxNedQi5BikeA+h0prXQJDXaAEp9ZU
         J9NPe7/yMBNQodFfyy1+ZwDwy/WmZ+j4Tw23Y2JAWOeX/SVdNU/kjX7SFv69cDuSE+20
         8cWld46NjsQvAB2OSJ4F4VLzId9NdDVBXGvnXcNxKbQ7LaiJqzqdapt1lkCxaQOQ36+w
         fMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqLm8EfM5SnlCMGedDjfLb4X4DuYoCJtVPMlQgV2X1o=;
        b=DQEJmiVPNezEUzpU0yNMrF4j+HBexa0rq0qYyc/T3UWb/0zSrCB/ifls6S9hkBL6z3
         SQgpxiqDfku4xEEd1iPRwxUa5Dnzz0z+Ahh3sT1nuk2/ow1h7H/WXOiL98ZgzvtzxWj7
         1WXpeiGklmP6vxIxujWyNMhzWqHOrT2392KXlA3BPag+QEZjYbCK495fhlpMmNObUpB2
         AbiBKKgeP4p+zFbfBhgHNmwEWKLwoy9l6zz58pAduTM9rSig6QbF9CrONf1iQ1iIZqXG
         NcGSguncc7rTSq7bV2Xzkxw5j+oJy9Ti8g1rq+LVRVWF1ZkEm847pTnZGja0CLrot4zG
         MgHA==
X-Gm-Message-State: AOAM532ZLV+SYYAPqcDOFbKaLHzKRJsTCeduAgfy5UFX8DdDcDL6OtRG
        3DwvelcUqapdTlB+Yd+xM8w=
X-Google-Smtp-Source: ABdhPJxxDI3VKUUUZ99T3bf6+3VsvDiJd6y55gmL4NRjzXdT/gModQr8wE9WiovQVUjYZngMsrXvCA==
X-Received: by 2002:adf:f302:: with SMTP id i2mr424571wro.186.1628097164373;
        Wed, 04 Aug 2021 10:12:44 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id j140sm2962191wmj.37.2021.08.04.10.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:12:44 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] pwm: mtk_disp: fix force reg to working reg.
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, ck.hu@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com, shuijing.li@mediatek.com
References: <20210724081849.182108-1-jitao.shi@mediatek.com>
 <20210724081849.182108-3-jitao.shi@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <925e1dcb-1f6b-1762-8342-b102d5e928e8@gmail.com>
Date:   Wed, 4 Aug 2021 19:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724081849.182108-3-jitao.shi@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 24/07/2021 10:18, Jitao Shi wrote:
> Disable reg double buffer before writing register.

The commit message does not explain why you move this from probe to pwm_config.
Can you please explain exactly why you need to do that.

Regards,
Matthias

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 3ade525adcc3..1070d78d4940 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -128,6 +128,17 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
>  					 mdp->data->commit_mask,
>  					 0x0);
> +	} else {
> +	/*
> +	 * For MT2701, disable double buffer before writing register
> +	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> +	 */
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +					 mdp->data->con0_sel,
> +					 mdp->data->con0_sel);
>  	}
>  
>  	clk_disable_unprepare(mdp->clk_mm);
> @@ -213,19 +224,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mdp);
>  
> -	/*
> -	 * For MT2701, disable double buffer before writing register
> -	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> -	 */
> -	if (!mdp->data->has_commit) {
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> -					 mdp->data->bls_debug_mask,
> -					 mdp->data->bls_debug_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -					 mdp->data->con0_sel,
> -					 mdp->data->con0_sel);
> -	}
> -
>  	return 0;
>  }
>  
> 
