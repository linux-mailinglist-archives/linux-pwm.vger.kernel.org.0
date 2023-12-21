Return-Path: <linux-pwm+bounces-595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5EB81B24F
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A911C21C74
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BA4E630;
	Thu, 21 Dec 2023 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwLPrSTR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F74E633
	for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso7046665e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703150630; x=1703755430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayJJhQ7i8rdsmjen++FBZiEstUK751hYv8bkP/oAYMY=;
        b=lwLPrSTRsP0Z8WCShKgAwHqyFr9MoxOALjWu2U7s0ieMHeY0jhkA2SPwFyM5Jmsm8s
         1XFSwCZXu1silgsY25WE2LVG7Y7wfTcGd8BoxD3oNTNBUc/qY1wMEdDIhmBNF3Frh6as
         2XQDEk4XwgCkhF+3DG0SWQTX/0PGN8e96/Qr4pDxCPjZD7KMgHDe/Vs4R4CIHnup6adz
         YRRtGsisDP6r2RrT0Yyt4n/8bNyQ2mrnLYKH+/RC6T0q17351luDSB1ppdUptZZ1V0VU
         gm14fqxy+TJN2H7HIYRQm6lFoPngoJA7xM3jZjRwlMuyAE/G1uqshlJDy1ctNKOD+YA4
         9z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150630; x=1703755430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ayJJhQ7i8rdsmjen++FBZiEstUK751hYv8bkP/oAYMY=;
        b=LYRV7+Rk9JBTKj/2HjmUvMDMbMOheui7L094lhR8MWsy+zxi7dfi69ahPXTd/h2saL
         Du2Ts08hFO91ZyP16MW3zaeL5x0iBb2dVOmo/TQCh3Baem/PBDn+6zeTUmAzYC6whJhn
         U+U2eP9KclHJq8+xo7k3AAOQj3LTHBj0j3uZqhorNv0xFAvpPP1iX774CfqPYm2ks6M+
         HOT3DXEz3bJqcW1N6dcPPeAII4wrTdox3nXUclCrYiPCzBYFgYztZjTohnX9aXxquhxi
         wMPR2wTjE+YlStX/mirq4HnAhX4gNVtJSBkCZj/Yc/Fb2SgW5A3eC14GFbGkxDLLV8Qp
         SC4w==
X-Gm-Message-State: AOJu0Yyr39CpZpe3HwRVX0wTbZqxGB+parMZrBPRMoouRImMsfbvLMB1
	Mh9P2Toov1mFlGmqQWI4MCdwuZN3BmGbIlCiqRCG48di
X-Google-Smtp-Source: AGHT+IGQPH4miJHwmO0WHsppv99frSCDU9pJ9/9tPZ+KEmh8y5PL5tj+Ty3LOIWLssOo3WFItjbqRw==
X-Received: by 2002:a05:600c:364f:b0:40b:5e1d:83a7 with SMTP id y15-20020a05600c364f00b0040b5e1d83a7mr596175wmq.59.1703150629738;
        Thu, 21 Dec 2023 01:23:49 -0800 (PST)
Received: from [192.168.7.29] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4b2a15ebsm2597888wmb.28.2023.12.21.01.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:23:49 -0800 (PST)
Message-ID: <bdfe5e63-6849-4025-80c1-e8071fce56f1@linaro.org>
Date: Thu, 21 Dec 2023 10:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] MAINTAINERS: pwm: Thierry steps down, Uwe takes over
Content-Language: en-US, fr
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
 <20231212203352.wl3rzob75fct4lov@pengutronix.de>
 <ZYMPc50eBi6oBClu@orome.fritz.box>
 <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 10:21, Uwe Kleine-König wrote:
> It's not easy to let go responsibility for a subsystem that one cared
> for for a long time, but Thierry realized that his heart isn't in the
> pwm framework any more.
> 
> Thierry cared for the pwm subsystem (commit 200efedd8766 ("pwm: Take
> over maintainership of the PWM subsystem")) as a maintainer during
> nearly 12 years. A big thanks for the time, effort and dedication spend
> during that time.
> 
> Uwe takes over maintenance.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello Thierry,
> 
> On Wed, Dec 20, 2023 at 04:59:47PM +0100, Thierry Reding wrote:
>> On Tue, Dec 12, 2023 at 09:33:52PM +0100, Uwe Kleine-König wrote:
>>> On Mon, Dec 11, 2023 at 04:24:35PM +0100, Thierry Reding wrote:
>>>> It all adds up in the end and keeps me from doing other things.
>>>
>>> If that means you'd be glad to give up the PWM maintainer job, I'd
>>> happily take over this post.
>>
>> "Glad" is not the word that I would choose. After all I've looked after
>> this subsystem for almost 12 years, and letting it go isn't something
>> that is particularly easy. However, I do realize that my heart isn't in
>> it anymore and I don't want to be in the way of anyone.
>>
>> So I'll take you up on that offer. Do you want to send a patch?
> 
> Sure, here it comes.
> 
> I hesitated to remove you completely, but I guess you intended a clean
> cut? Or would you prefer to stay as a reviewer?
> 
> Usually I would have added you to CREDITS, but as you will continue to
> fill your various other responsibilities (I expect), this felt wrong.
> 
> Best regards
> Uwe
> 
>   MAINTAINERS | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5342cf32d73f..16c6aa0ad1ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17561,12 +17561,11 @@ F:	Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
>   F:	drivers/media/rc/pwm-ir-tx.c
>   
>   PWM SUBSYSTEM
> -M:	Thierry Reding <thierry.reding@gmail.com>
> -R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> +M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>   L:	linux-pwm@vger.kernel.org
>   S:	Maintained
>   Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux-pwm.git
>   F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
>   F:	Documentation/devicetree/bindings/pwm/
>   F:	Documentation/driver-api/pwm.rst
> 
> base-commit: 881791886bfa8e353c3203f95bfbaaeee25d2d50

Thanks Thierry for all support and work over pwm and your help for pwm-meson!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

