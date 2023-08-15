Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED977D4B8
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Aug 2023 23:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjHOVAg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Aug 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbjHOVAF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Aug 2023 17:00:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2A10EC
        for <linux-pwm@vger.kernel.org>; Tue, 15 Aug 2023 14:00:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso49749125e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Aug 2023 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692133199; x=1692737999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUh3d8Lt7h78kSmqim/NK0v26wjsQ9UPaRp1gHVVLo8=;
        b=tfxl1J+rEIE3RPV5s+HiYSSmR8o3fwI4rI7kmbxDGa1qQl7mFASsACCcBG4tmCBqlR
         9ysXL06I0IHZJix2RiiaetlvM8QBPcwn/WsEnPTvyPXtauzT2xeXvAV+zEmUUhOYeibD
         I8YpqAdiuPgxg6sePWl0vU8RSoCHfTWoaBHvkUSqCSAWzwH8JU4tqvv1Uso9rIaO+ZCs
         IcKLflToXoiJmS0DF1owHeFiY8bHFPE9a0FM+Lc4CCgLfWvarmy0LZCq9yAdFRFBAtw1
         4kWs28w0XrSurCux7MWrFxfpzhluB8LgqGLSgrZSk588Kc883RFYpw3f/exZtt4u6NNL
         LZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133199; x=1692737999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUh3d8Lt7h78kSmqim/NK0v26wjsQ9UPaRp1gHVVLo8=;
        b=bYvxocLrLx8I02sutZ7bld2YRC2fkfUPyFE8ce6Ub0ynowl1yNrupBCtmaMm5SNSXo
         rgnNdkJ3zG7ZA+QNiLycrMB34p86yBuW+iYEmXGSUlxdRzG/4SWWuDAK1TfQ9wQsJ/ec
         lK+jbzs88TL7hWAT2WOt5WrNwJXCnfDd0jOcJ0j7glG9Z2C4h5prPKphPJ7PzjD64xYk
         YMd5BatX8M0hXh7Oj76PPgHpM8D/Om9WYh05w73etlOyKX64FBip/WqXoelp9s287jIL
         D57ec34qvPVKsNPPXtj0YMGQ3BaGVN8rAD49cnxcX+JH2H4YINpm8eei9oYaT71opnhw
         zbHQ==
X-Gm-Message-State: AOJu0YzmerM/Y/iD0ZjCzFj8/1t7mOmT6wSgasR7NK93lDLsEpaEyz85
        YEGkksaEGn8/gKKuIp3jbhzf1Q==
X-Google-Smtp-Source: AGHT+IHPR5ZgIquj78Pw6M82XZhDr7Qg0j9byeQ7z5RcXbozmJwaicWWbYDePNqCmEBEVYDTpuPHHQ==
X-Received: by 2002:a7b:ce94:0:b0:3fb:ff34:a846 with SMTP id q20-20020a7bce94000000b003fbff34a846mr10667435wmj.22.1692133199585;
        Tue, 15 Aug 2023 13:59:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fa8dbb7b5dsm19027605wma.25.2023.08.15.13.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:59:59 -0700 (PDT)
Message-ID: <3efc0e28-3a5a-bfc7-57e3-e7e3d5ae1740@linaro.org>
Date:   Tue, 15 Aug 2023 22:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 01/13] dt-bindings: pwm: rockchip: Document rv1126-pwm
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Jagan Teki <jagan@edgeble.ai>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <20230731103518.2906147-1-jagan@edgeble.ai>
 <20230731103518.2906147-2-jagan@edgeble.ai>
 <20230731145129.mrrkb6tcuvlpmxan@pengutronix.de> <5533260.88bMQJbFj6@phil>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5533260.88bMQJbFj6@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/08/2023 16:02, Heiko Stuebner wrote:
> Am Montag, 31. Juli 2023, 16:51:29 CEST schrieb Uwe Kleine-König:
>> On Mon, Jul 31, 2023 at 04:05:06PM +0530, Jagan Teki wrote:
>>> Document pwm compatible for rv1126 which is fallback compatible
>>> of rk3328-pwm group.
>>>
>>> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
>>
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Should this go in via the pwm tree, or together with the other patches
>> via rockchip?
> 
> I have no clue, sadly. I _can_ pick it up, but I guess that would
> require an Ack from Thierry? Otherwise I guess we'll need to wait
> for him.

General preference is that binding goes via subsystem (so Thierry), but
there are no driver changes here and your DTS branch would benefit from
it (less dtbs_check warnings). Therefore I propose - just grab it -
unless Thierry wants other way.

Best regards,
Krzysztof

