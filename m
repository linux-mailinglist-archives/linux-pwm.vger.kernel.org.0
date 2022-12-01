Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1763EAC4
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 09:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLAIDx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 03:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLAIDw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 03:03:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AD2EF7D
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 00:03:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h12so1348065wrv.10
        for <linux-pwm@vger.kernel.org>; Thu, 01 Dec 2022 00:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RAIQbbxtK2nJ1NbUghrZ93yJMEm2LyReQuktQwQ+yXw=;
        b=Lo8p+aDFlKlZfG6pP0n7RZNEjwZK+wrouNetRK3rZv63MbeCUctT1ieDjkKZxl3LvQ
         1IUxcYuylIWjoy7vKgfrNL5bEmzdei5+43ayKtzqRIyOjWYlsoDieQD7IgspPDeYN4Rg
         g0Tg2r6urLUhUddkFA8F1g+Y6MZ6LYzNVPQKNUdc62bCqGXALe+tEuJdy6U6nHFQ1VTs
         pd9A/smgMPI5kbQN+yqEnGZNPKCbNRwE4VhlqdS4p01McAPr9GKRJDIzQjVNyphai7am
         M+pt/qh8ja70rWDWaq5xcHGdzPkZEr0JVoVeIN0FLdIf+5vnAZEi/TDzF6dIxj4puvKU
         V1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAIQbbxtK2nJ1NbUghrZ93yJMEm2LyReQuktQwQ+yXw=;
        b=CmRzIvFk04Y/LZ4xqMtdb8wJMXyFEUZysghDDI67ZtM1LbJBsS30u7iBqYMNhsXgtH
         M45mZYSy5QpJgupShTL1ed3WaFLtJj65Z23VCIVAeaBbI3rP+Eh3bGQZJnI8Xc6PnCt1
         HStbTM4tCwX7inEozNZIVXkNfHJV+cfaK6Ow2PsOi6JVe2H6ee5RDjNasb3UXNoaTtTU
         wqT/PJtLlMjkO/Eyl//oaW2G5xrswPrM1cDU8/a0tsaXkCvNukdLb5NS1W/JJY06z6qP
         A2WGYtyrgulPc6mNRFQBO2mkzch5U+xAeIrBNbCsAoJr8iIW5//einV3f37R76vTAkBR
         IDww==
X-Gm-Message-State: ANoB5pkxlBkxKa+zyLyjM8/IHQNxdtlvFI37VXM2OQcrob66BBl4QLUj
        9PYrDKzps15AjaJOCoRbuO99zA==
X-Google-Smtp-Source: AA0mqf54lvafHdVKKM2CGBzb3Ly91fbeS37TZTU/o75hgaix+kcG2rGxchFiaWC/vEjl7eP4KzxYJQ==
X-Received: by 2002:a05:6000:1d92:b0:241:6e0a:bfe6 with SMTP id bk18-20020a0560001d9200b002416e0abfe6mr31726074wrb.34.1669881828568;
        Thu, 01 Dec 2022 00:03:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bec0:73a:70e1:228f? ([2a01:e0a:982:cbb0:bec0:73a:70e1:228f])
        by smtp.gmail.com with ESMTPSA id az39-20020a05600c602700b003cf78aafdd7sm4517313wmb.39.2022.12.01.00.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:03:48 -0800 (PST)
Message-ID: <b19c4956-3f92-f6be-7d61-9b826e5d6fe1@linaro.org>
Date:   Thu, 1 Dec 2022 09:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 01/11] pwm: Make .get_state() callback return an error
 code
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Douglas Anderson <dianders@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221130152148.2769768-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 30/11/2022 16:21, Uwe Kleine-König wrote:
> .get_state() might fail in some cases. To make it possible that a driver
> signals such a failure change the prototype of .get_state() to return an
> error code.
> 
> This patch was created using coccinelle and the following semantic patch:
> 
> @p1@
> identifier getstatefunc;
> identifier driver;
> @@
>   struct pwm_ops driver = {
>          ...,
>          .get_state = getstatefunc
>          ,...
>   };
> 
> @p2@
> identifier p1.getstatefunc;
> identifier chip, pwm, state;
> @@
> -void
> +int
>   getstatefunc(struct pwm_chip *chip, struct pwm_device *pwm, struct pwm_state *state)
>   {
>     ...
> -  return;
> +  return 0;
>     ...
>   }
> 
> plus the actual change of the prototype in include/linux/pwm.h (plus some
> manual fixing of indentions and empty lines).
> 
> So for now all drivers return success unconditionally. They are adapted
> in the following patches to make the changes easier reviewable.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/gpio/gpio-mvebu.c             |  9 ++++++---
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 ++++++++------
>   drivers/leds/rgb/leds-qcom-lpg.c      | 14 ++++++++------
>   drivers/pwm/pwm-atmel.c               |  6 ++++--
>   drivers/pwm/pwm-bcm-iproc.c           |  8 +++++---
>   drivers/pwm/pwm-crc.c                 | 10 ++++++----
>   drivers/pwm/pwm-cros-ec.c             |  8 +++++---
>   drivers/pwm/pwm-dwc.c                 |  6 ++++--
>   drivers/pwm/pwm-hibvt.c               |  6 ++++--
>   drivers/pwm/pwm-imx-tpm.c             |  8 +++++---
>   drivers/pwm/pwm-imx27.c               |  8 +++++---
>   drivers/pwm/pwm-intel-lgm.c           |  6 ++++--
>   drivers/pwm/pwm-iqs620a.c             |  6 ++++--
>   drivers/pwm/pwm-keembay.c             |  6 ++++--
>   drivers/pwm/pwm-lpss.c                |  6 ++++--
>   drivers/pwm/pwm-meson.c               |  8 +++++---
>   drivers/pwm/pwm-mtk-disp.c            | 12 +++++++-----
>   drivers/pwm/pwm-pca9685.c             |  8 +++++---
>   drivers/pwm/pwm-raspberrypi-poe.c     |  8 +++++---
>   drivers/pwm/pwm-rockchip.c            | 12 +++++++-----
>   drivers/pwm/pwm-sifive.c              |  6 ++++--
>   drivers/pwm/pwm-sl28cpld.c            |  8 +++++---
>   drivers/pwm/pwm-sprd.c                |  8 +++++---
>   drivers/pwm/pwm-stm32-lp.c            |  8 +++++---
>   drivers/pwm/pwm-sun4i.c               | 12 +++++++-----
>   drivers/pwm/pwm-sunplus.c             |  6 ++++--
>   drivers/pwm/pwm-visconti.c            |  6 ++++--
>   drivers/pwm/pwm-xilinx.c              |  8 +++++---
>   include/linux/pwm.h                   |  4 ++--
>   29 files changed, 146 insertions(+), 89 deletions(-)
> 

<snip>

> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 57112f438c6d..16d79ca5d8f5 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -318,8 +318,8 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
>   	return cnt * fin_ns * (channel->pre_div + 1);
>   }
>   
> -static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> -				struct pwm_state *state)
> +static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
>   {
>   	struct meson_pwm *meson = to_meson_pwm(chip);
>   	struct meson_pwm_channel_data *channel_data;
> @@ -327,7 +327,7 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	u32 value, tmp;
>   
>   	if (!state)
> -		return;
> +		return 0;
>   
>   	channel = &meson->channels[pwm->hwpwm];
>   	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
> @@ -357,6 +357,8 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   		state->period = 0;
>   		state->duty_cycle = 0;
>   	}
> +
> +	return 0;
>   }
>   
>   static const struct pwm_ops meson_pwm_ops = {

<snip>

For pwm-meson:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

