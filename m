Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1135F1B35AA
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2020 05:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVDnl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Apr 2020 23:43:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54909 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgDVDnl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Apr 2020 23:43:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 12B025C008C;
        Tue, 21 Apr 2020 23:43:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Apr 2020 23:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=2
        pJX7Yg+sQ/AyYD6L8gjHh63yS93sxWkwLxkCvnI+ek=; b=SUr/qn7fhubwORw6r
        1SR1sDofmVTFUbL2y0aluMDxkSGyAp1JV9NqfoBrmMZEAev+b7/MxxOFbt9w7orK
        lUq1CGofBI93ZRVKcgJ0X+4czDPtNhntXkWz8azKX7Mq34PtY5GwhgB5ukVTSO94
        y83SC6XxnrVsNt9vxoD0DxbwdLOlh0sCGhrxFY/6qndn1uecSkUStY1AxkcH4esY
        PlxOjFHQVsEytDwCu8IWG8jKNOrRARJ2zU5t+hjIj8OItQZMXbQFKn3959Lf3Knx
        7NOxuYQJFsPR8K5mNS4FBrYiKQn/wGSggYfQNHatsjiCLcFFeLXGnjbHJl+XMnTO
        C6USw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=2pJX7Yg+sQ/AyYD6L8gjHh63yS93sxWkwLxkCvnI+
        ek=; b=pEDjSUE1KhTlyS+psV8vjg4C1Tyf6w6G+iTzSvAiQ1Pu/GPPmA/Wpxju4
        SkMwqtzAf4viQKZBKvxTYN4EuXT+Kz2lzCCMt74s04/G8tW0aLfqCryiy6/J1WUC
        yuCprfcsr9Hh7Bye9JhgzEv6qBx3QjMNBq6u31+5pPVLuqr5rKJZC1VzSFv8cI4q
        SgJ9wc8ZU5DkTJzQ39hfI9feYy2RTSQ4g8VIYx3kQe6lXOAjvSd/fwQECz8B+q2y
        mWVGYHwM6jkRumlYmRu3/1QFHITmhvBnueLN19+NXkSWmXEwprHM8zpsZ125KPy7
        Gv48rfuu8YIG63gWjkYU+IoTsWqGg==
X-ME-Sender: <xms:a72fXl1iQLl-hxurLDCJOq4UcTOlYCAoULamXhs92wLvx1UZo5cZig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeeigdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:a72fXtYgV6rQfSAYqart0nvBnVlL9KjQo39zrgU259M2Cu6-FzEpog>
    <xmx:a72fXqhDEEPTT-D7lKYImMPPJhMgHl8famBhYC3lucKX_t8_AtQuSA>
    <xmx:a72fXlhmUeT3Q19ZdBKOazxMRNHTnYt6lWWuhtkSFKAdaMiibpkwMg>
    <xmx:bL2fXlphHTNRxzMA5Dni2eoELwMRrM5WNxGoeXAN_SWRsCeie_Atug>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5921B3065CB0;
        Tue, 21 Apr 2020 23:43:38 -0400 (EDT)
Subject: Re: [linux-sunxi] [RFC PATCH 4/4] pwm: sun4i: Delay after writing the
 period
To:     dev@pascalroeleven.nl, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <20200317155906.31288-5-dev@pascalroeleven.nl>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f1d9a17e-df9e-dc12-603d-84e908a04b81@sholland.org>
Date:   Tue, 21 Apr 2020 22:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317155906.31288-5-dev@pascalroeleven.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Pascal,

On 3/17/20 10:59 AM, Pascal Roeleven wrote:
> When disabling, ensure the period write is complete before continuing.
> This fixes an issue on some devices when the write isn't complete before
> the panel is turned off but the clock gate is still on.
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  drivers/pwm/pwm-sun4i.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index a11d00f96..75250fd4c 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -299,6 +299,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>  	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
>  
> +	/* When disabling, make sure the period register is written first */
> +	if (!state->enabled && cstate.enabled)
> +		sun4i_pwm_wait(next_period);
> +

It is not visible from the context of this patch, but this call to
sun4i_pwm_wait() ends up calling msleep() inside a spinlock, which isn't
allowed. The spinlock should probably be converted to a mutex, considering that
sun4i_pwm_apply() already sleeps and takes mutexes.

Regards,
Samuel

>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
>  	else
> @@ -320,6 +324,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return 0;
>  
>  	/* We need a full period to elapse before disabling the channel. */
> +	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
>  	sun4i_pwm_wait(next_period);
>  
>  	spin_lock(&sun4i_pwm->ctrl_lock);
> 

