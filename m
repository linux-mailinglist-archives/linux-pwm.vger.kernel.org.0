Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53E3C6A43
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhGMGPs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 02:15:48 -0400
Received: from birdy.pmhahn.de ([88.198.22.186]:57216 "EHLO birdy.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhGMGPr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Jul 2021 02:15:47 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 02:15:47 EDT
Received: from [IPv6:2003:e2:7738:c200:a5ae:ca72:d4d5:6724] (p200300E27738C200A5aEcA72d4D56724.dip0.t-ipconnect.de [IPv6:2003:e2:7738:c200:a5ae:ca72:d4d5:6724])
        by birdy.pmhahn.de (Postfix) with ESMTPSA id 626F62208EDA;
        Tue, 13 Jul 2021 08:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=202002;
        t=1626156148; bh=HfuvmijpRKAZ3kq4/6lrXulnT7YaLAQipZHwr6kr8E4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LYIB3WsIHggROpun740ag9e7XbypxixZ7+A8tFMhcdDqX/BKG9jLUjKLpu4NFLMvq
         0tXGrnAMg2+aZO+6LulZj++mey3V94gkXReys0qXDjGag3e6HWTeYeGsiiba7VdldA
         g/jVYlxxKDB1N5mW512dO9HEe3FuPoERGdbfANO7vezjSLvBUWPnMD4LGDpPhOl/PW
         f+glKg7wSMqU4oucsqYG4AX0UTn7h4OwQBsWXjbMRQ1cL4nnfd1N377WGdmz5MzMfl
         ux5aZ71QWZJaLJbn6Zz7UMdsU8T1HXLDlkVmb30TTAwrjp54J2j65B5D5oHMGQRiPp
         57OhLqZcJW56w==
Subject: Re: [PATCH] divide by 3*sizeof(u32) when computing array_size
To:     Salah Triki <salah.triki@gmail.com>, fabrice.gasnier@foss.st.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210712231910.GA1831270@pc>
From:   Philipp Hahn <pmhahn@pmhahn.de>
Message-ID: <e597d6b8-55d6-2fa6-5f79-86ff813d8bd2@pmhahn.de>
Date:   Tue, 13 Jul 2021 08:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712231910.GA1831270@pc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

Disclaimer: I have no idea what 'pwm-stm32' is or does

Am 13.07.21 um 01:19 schrieb Salah Triki:
> Divide by 3*sizeof(u32) when computing array_size, since stm32_breakinput
> has 3 fields of type u32.
...
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -544,7 +544,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>   		return -EINVAL;
>   
>   	priv->num_breakinputs = nb;
> -	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
> +	array_size = nb * sizeof(struct stm32_breakinput) / (3 * sizeof(u32));

Maybe it's too early in the morning for me, but this does not look right:

> struct stm32_breakinput {
> 	u32 index;
> 	u32 level;
> 	u32 filter;
> };

then "sizeof(struct stm32_breakinput)" == "(3 * sizeof(u32))", which 
would simply make "arrray_site := nb" ?

Philipp
