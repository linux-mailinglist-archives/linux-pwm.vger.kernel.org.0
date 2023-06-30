Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB974394F
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jun 2023 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3K0D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Jun 2023 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjF3K0B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Jun 2023 06:26:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A82952
        for <linux-pwm@vger.kernel.org>; Fri, 30 Jun 2023 03:26:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98d34f1e54fso186916966b.2
        for <linux-pwm@vger.kernel.org>; Fri, 30 Jun 2023 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688120759; x=1690712759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgUhcpjTGiXDPm11FEABoqmACOXtom4yU9rCcxjxYIs=;
        b=sYXnO/iYoSb91A0MJA7UGr8luu0VOZmdLA+ekOEHANuHUqIgUdHI/OAoX4lKL7HLcb
         j/+p/A5RSVMW7ScVk2umzQoHIA6mZ53aNsdqWH82tRFNW0cyHX8Nt0r5O8kdfGMOEYlm
         iKFtr3WNCLv9ueFBBkcGWCVAekuejR+jbcHhGecaivkwzIdOXVenQguh1zYyjGM6js7a
         KvarAQcbxX2C8HIAOtg5dXiiVKxZUDym6SzvGLPtLhYck0eTQzGM++mhWZljZqBzze6D
         APP3X1X+QQJFngv9KzY7GcWp9FOmx9WYQSR+DRn7Oo753cERrc1KzOGV0LEbBTi4f9MU
         H8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688120759; x=1690712759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgUhcpjTGiXDPm11FEABoqmACOXtom4yU9rCcxjxYIs=;
        b=hI8l9dE//hTUuUQRG8/0qz9ai1H3pcm0BK53PKdv4OaBOlZd1qCIKfLw8O1Bfe13PF
         L/YnPHAKZ44jSeazZw6iUECYqfNZG/Sx6mCQKkX8f26Y/r9/AuuiNPW0wWR1FeKJCzgi
         JuXs7Z8EbesApOif1MS8m2uqqwVLOg9XYRm3mWGLjTA7xGfBzaOYEg9Jx8miM5YliGGb
         MTEp9q+pwSOkH24PjlpQFrBYdjJ8Hld48gfjttx3lpbk5ai/tR9jt5qV+ri9NHFEP3dM
         eovnPaVLLNrQBX/COjnvS0ysXO98Eki0VQ9nfPQyPUcnhvyKWDAfOl9zY424jZBUSY9m
         VWcA==
X-Gm-Message-State: ABy/qLYoIpBwFRcEY0CALSynGYcEl4pgn1OBQVRnpYDTRxPwbnJnJdql
        +SaGTbUls8Uu48L9ydKjdKLY25lFcT99CezDmmY=
X-Google-Smtp-Source: APBJJlG0FH0tYyeB3HU4LuLg1dicCSOkXTHiDH2XjMVg9JKwab1fm08F4rNviOokTskexCdGZ99iKA==
X-Received: by 2002:a17:906:d7ac:b0:991:c842:2ca2 with SMTP id pk12-20020a170906d7ac00b00991c8422ca2mr1398727ejb.15.1688120758982;
        Fri, 30 Jun 2023 03:25:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709064a8f00b00993017b64a8sm5205eju.224.2023.06.30.03.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 03:25:58 -0700 (PDT)
Message-ID: <0464bf9a-2fcd-cd55-e591-43ea0dc7beaa@linaro.org>
Date:   Fri, 30 Jun 2023 12:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 3/8] pwm: jz4740: Put per-channel clk into driver data
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
 <20230629094839.757092-4-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629094839.757092-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 29/6/23 11:48, Uwe Kleine-König wrote:
> Stop using chip_data which is about to go away. Instead track the
> per-channel clk in struct jz4740_pwm_chip.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-jz4740.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

