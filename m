Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E66F3193
	for <lists+linux-pwm@lfdr.de>; Mon,  1 May 2023 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjEANjx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 May 2023 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjEANjw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 May 2023 09:39:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D0A2
        for <linux-pwm@vger.kernel.org>; Mon,  1 May 2023 06:39:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so24105605e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 01 May 2023 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682948389; x=1685540389;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlhw3R1Et9Ige2ykqVvApm57kkVujOZ5DEuJEE6AOc0=;
        b=YDREZu/Bm+VSwBEMJ/BTbU7Z7S4jzPjNbubNRvsoRJMO23Xy3AzcROpIdYZEK7PteC
         TvFYX6bWVi+IEqeoq4M0qLmGjpR4m1S757qx3VQBmMmaL7y2fIKj9LYhQA8i4IXI/EsD
         xFgsoocSOCzobnZB+UdUZOlcdRr/MqN+obcP7Iol2Af13TYxpe2/dfK2ubF3OoYzKmW0
         rT92W7UXo6bvr8a2j0FxFkFU7SiMWQiT2roDa7ZNDze8wGKaJvf6yp1VY4vYYrcZ83iu
         dia3VaKueAv0D3hZ83j0fzQ4xCpW4iieALe5gzq4x2IcE50Wp9/Qa1clBRzAG/biMm0j
         jGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682948389; x=1685540389;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlhw3R1Et9Ige2ykqVvApm57kkVujOZ5DEuJEE6AOc0=;
        b=BOO93E2zzXfMZLQxGn2t4gd5HZl+rm2yNJwztCTKuq3L9hTFFqOmEinmrPvnDA1X2L
         YYq++otQvBAihDdYu3FKK5OI0J9gn0AvRjMRMb7zb/ltRlerr6a29CDgnPprJoYicLXW
         bo0XGx1oJ5EIoQxSq4lQI3OJRY0zSe4BqAjHGXtWjiMPVdM3u3cG6COpAr9/fLwF2qT2
         v+F+xheGC9Xa6LW0rUWXAh2i66oxxfoNqPpXCILmoZevcHifwovpygc1BLh9ftBXFqRK
         dD/5NdNeNuo04komlq79wkdLjWxdlDrig3j6+rIC2JCdgv7Zfhwuymzji0FtuWStf0Yo
         1a0A==
X-Gm-Message-State: AC+VfDx0XpscdSH0XhjbP2KBJfqYlQMMt8gNp5dcoCd2sxdnamuJHSm/
        xUcIimincsAJHTBfMj1iklI=
X-Google-Smtp-Source: ACHHUZ6wXgWBbnI/BnI9hDArcOeffNTl2MwnkytVZA2jcyW+uh+BfttVKQeL0+wUUoe2i4z5VN7cqA==
X-Received: by 2002:a7b:c008:0:b0:3f1:7a18:942e with SMTP id c8-20020a7bc008000000b003f17a18942emr10254471wmb.6.1682948388871;
        Mon, 01 May 2023 06:39:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9bd:5800:60ec:422b:628c:6ca5? (dynamic-2a01-0c23-b9bd-5800-60ec-422b-628c-6ca5.c23.pool.telefonica.de. [2a01:c23:b9bd:5800:60ec:422b:628c:6ca5])
        by smtp.googlemail.com with ESMTPSA id x8-20020a05600c21c800b003f2390bdd0csm23781162wmj.32.2023.05.01.06.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:39:47 -0700 (PDT)
Message-ID: <7cacf0f4-099c-766d-5757-cc3813ec09a8@gmail.com>
Date:   Mon, 1 May 2023 15:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     neil.armstrong@linaro.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
 <73a52391-b380-e491-0e96-5c51c7be487c@gmail.com>
 <22b6f870-8dfd-c01b-a7cd-383a9d9ece20@linaro.org>
 <872b3270-8319-6b4d-9d52-1da0b58d4e19@gmail.com>
 <229e20ef-6e99-6d52-b0e6-a357a184b6af@linaro.org>
 <87f14a9d-f341-d694-f567-7f9e78666b5d@gmail.com>
 <CAFBinCAF4oc+FoG8CtQhpSHSAkODQFXGbt5OvtprGSb4s+fWqg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
In-Reply-To: <CAFBinCAF4oc+FoG8CtQhpSHSAkODQFXGbt5OvtprGSb4s+fWqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23.04.2023 22:58, Martin Blumenstingl wrote:
> On Wed, Apr 19, 2023 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> [...]
>>> This is a hack based on current clock values, either explicitly support a code path
>>> where pre_div = 0 or if you can't do that with CCF implement the pinctrl way to handle this,
>>> which is the cleanest.
>>>
>> To make it explicit we could request ULONG_MAX as rate instead of 1GHz, this would imply
>> choosing mux parent with highest rate and pre_div = 0. Up to you whether this would be
>> acceptable.
> I like the idea of using ULONG_MAX as I first had to think about why
> you chose 1GHz in the driver.
> 
>> AFAICS pinctrl would need quite some DTS changes, and it's not my area of expertise.
>> So it would be open who can implement this.
> My opinion is that this can be done in a separate patch. We need to
> work on this whole thing anyways as you mentioned that newer SoCs
> (from what I understand: G12A onwards) have a dedicated "constant
> output" bit which will make the pinctrl solution unnecessary (at least
> based on how I understand it).
> 
Agree.
My understanding of the "constant output" bit is, based on the vendor driver:
W/o this bit the chip internally increments the lo and hi value. Not sure by the way
how the chip handles value 0xffff, whether it omits the increment in this case.
W/ this bit set the chip doesn't increment the values, therefore lo / hi can be
effectively zero.

> 
> Best regards,
> Martin

Heiner
