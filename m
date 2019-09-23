Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B22BB0C9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393492AbfIWJEn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 05:04:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44418 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393251AbfIWJEn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 05:04:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so9465422lfc.11
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2019 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0JN1h+SdmbTH3kP7+d/LSAM256ls91/0oIY0PsAnI9c=;
        b=aHR6ZebyZ8DZpvzN5FPwizkSeWcTkugKWZ3zU5/wa6l5Q54ddMLdKKjzClEkVBcAIr
         R9Q0bAQBeD134Z05K7waWJ3GB31hRmYeoFBRNl9zeHVJguBN1TqCMfcnOhtE6FKLfkxC
         CB14f/dGMHvj7B3B1ElGiiHTXvRW9zUSm2oWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0JN1h+SdmbTH3kP7+d/LSAM256ls91/0oIY0PsAnI9c=;
        b=Mztelvm1eeKSXxptHOrlhavd5tRRaVKOV3xD+dTigOtujufRlhk+ovporcXA8K26fj
         VR7a3qXuKsQS8DN/mo4Inob3HwVrVP6Qbj9LGP+gzaTC3YbRcEs+mKnyC5t/90Qp+xqc
         9a8+NOGN/tHll9vktJ0MA8SXST7MeFBWm/YX61PrgKCfQUiAi4Xx1r0TzQ8fdvNLLDCB
         ZmX/eA7rknUFuVAkQiuyr5uiT/pflSI8sxSUd2fECk+yiArn4XMMzbhF4FOOAVDOXZ9u
         71pssEhDrn2dnjXm+jN5PbRgdp0GXgIOyI6XYOqsTWKAQKPwVVAwZmQ5wP10MccrNZbP
         8Izw==
X-Gm-Message-State: APjAAAWTVtMisXIuqWF79XQ4EYVBWBnWU+KEAyDUVUydgVMD5B+7a9Pm
        T54itaxKcsS102NRM3Py6qnRuw==
X-Google-Smtp-Source: APXvYqxE0UImPNGet4+HJgvkP3IVnXfnoznq6mWvl/4K5U7NnkgngpqSc4uPgwZPAR8lLmN00SF+gg==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr16518413lfm.107.1569229480930;
        Mon, 23 Sep 2019 02:04:40 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g26sm2174673lje.80.2019.09.23.02.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:04:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
 <20190923082459.huqpbz5eseonkscv@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
Date:   Mon, 23 Sep 2019 11:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923082459.huqpbz5eseonkscv@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/09/2019 10.24, Uwe Kleine-König wrote:
> Hello Rasmus,
> 
> On Mon, Sep 23, 2019 at 10:13:45AM +0200, Rasmus Villemoes wrote:
>> In preparation for supporting setting the polarity, switch the driver
>> to support the ->apply method.
>>
> 
> Maybe it would be easier to review when converting from .config +
> .enable + .disable to .apply in a single step. (Note this "maybe" is
> honest, I'm not entirely sure.)

I tried to make .apply do exactly what the old sequence of calls from
the core to the individual methods would do, and for that it seemed a
little easier to keep the old methods around - but yes, I do need to be
more careful than that to provide the atomicity guarantee that the
legacy methods did not. It's also much easier to squash than to split,
so for now I'll leave them separate - if somebody prefers them squashed,
I'll do that.

> There is a bug: If the PWM is running at (say) period=100ms, duty=0ms
> and we call
> pwm_apply_state(pwm, { .enabled = false, duty=100000, period=1000000 });
> the output might get high which it should not.

Ah, yes. So I suppose that if we're changing from enabled to disabled,
we should simply disable it in the CTRL register before changing the
duty/period.

> Also there is a bug already in .config: You are not supposed to call
> clk_get_rate if the clk might be off.

Interesting, I didn't know that. So the prepare_enable logic needs to be
moved before we start computing the period/duty cycles. Do you know why
it has apparently worked so far? I would have thought such a rule would
be enforced by the clock framework, or at least produced a warning.

Thanks for the fast review. I'll wait a day or two to see if there are
other comments before sending out a v2.

Rasmus
