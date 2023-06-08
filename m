Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2811727769
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jun 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjFHGj1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jun 2023 02:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFHGjZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2023 02:39:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645752120
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jun 2023 23:39:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9788faaca2dso51546366b.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Jun 2023 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686206363; x=1688798363;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20VwnX/WoaRKV9arNTXMhn8ioZI7RTq9D1ov94KZAt0=;
        b=GBvMPK/cs2To8yEXE9SsipYC/K1njPu288BNro/g9k2fonTbbPNHjR6x/v6lQUDK1X
         BAS3uVWDIcWav1fDn/+ErtHtI7UEwBChae4r6rHEQMuY/PtUZrRTn4FVSI5aosRItmCw
         K/FePCj+GiqS7lxluja8iwNLBGIHNfZTg528SQ89huvg5dJ5iHnnbrCZEmf23JyU8lUe
         /SpaTtwUyRK8fgCmvhCmnzoZX3t2SRvOH6XyQ4bNSXGBXwKtRn31zQ/i8BijKOmZOV6C
         e8nS4f7O07aT7ZkG40L16LctrvwEkwkmMoKd31xIw3hk9r+D3QelJVr/FHc6AlSw5vb8
         LDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206363; x=1688798363;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20VwnX/WoaRKV9arNTXMhn8ioZI7RTq9D1ov94KZAt0=;
        b=AGKXkFRQGmYBQxROQ2e7vpxMYv5Z7E5CzibuHMOLGlHGnehbICeaeVWCPbqtsdD3+g
         kFUSM/ogOV2cbX891JNgwpo5sh0fZsrGgOkLmJvm2o98xEaS1cHNLQQZP8jTxgdAhdHI
         cDxdzKoPLliAsDaCER9+xh1s7zKcdtWt/zTQzjWmIYszuE5Q8nIOGcJ7ncSjboQlSZNk
         9P4c3iLZzrDM7nGP2czxmSZp44YozzDizdsDmELztyFu+X0lOwfs5Q6QZvfmvBhuoV0I
         0BAbmK6nGAxu2iqsjV9ZwMaxuwc2q87UKQggD2quILHETHGK4OfQA6bkH8xl1iT2kJlj
         cy/A==
X-Gm-Message-State: AC+VfDzKRpkNHyENceU5ZF86uGw0IEO6XGjNG7m5/nWYnQpkdURqkS/R
        EbGa3e5JDH7J1IFuvEs0KAYi4A==
X-Google-Smtp-Source: ACHHUZ4hT0e0tzGvbuWncVx7177VvT2kgg6YTLUjvuP4pV7zePZzqsLUl/diPhvVAIOjdTJZ3WZG2A==
X-Received: by 2002:a17:907:1c0c:b0:973:d857:9a33 with SMTP id nc12-20020a1709071c0c00b00973d8579a33mr9347535ejc.11.1686206362925;
        Wed, 07 Jun 2023 23:39:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090616c400b00977d7ccd9fdsm272257ejd.95.2023.06.07.23.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:39:22 -0700 (PDT)
Message-ID: <b0f5f061-60ce-815f-4228-2033335e562d@linaro.org>
Date:   Thu, 8 Jun 2023 08:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608021839.12769-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/06/2023 04:18, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm device.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

I don't understand why you make the same mistakes, even though I pointed
them out two times already.

I am not going to point third time. Sorry, it's a waste of my time.

NAK.


Best regards,
Krzysztof

