Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BE619ADE
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 16:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKDPDZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKDPDD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 11:03:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12640DB0
        for <linux-pwm@vger.kernel.org>; Fri,  4 Nov 2022 08:02:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l15so3175229qtv.4
        for <linux-pwm@vger.kernel.org>; Fri, 04 Nov 2022 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXpJ0TQUpxsncyPGT+WrGCwDjQwyOyScZvMWbiWmnqQ=;
        b=BTL7O5jCNWCOVPuY/W40A9ZQpJfM1th2R1rLnajP5f+y61WwyFbrbuDfXZllXv3nOw
         EaxLzQqMTBPWjreEnFuO489x41xDipMLGIUF3aPN3DXO3r8Nzm5Qi+gCRji21E1SvZBc
         qFPh6a1SFScn8hdSQ97lFfZB4UroUGC0JyB5x5cZiXlBoNjRPqirSLrCvcrDTdS5rLEp
         vFtiEs05Qnk8upbNKke7jCYnCwFmrlokkq+ugOi6yOdVFNYdu5D5lO4dkuTk5xx6/xw5
         odgfl6nt2QbirMsBcWl/2EcIru/BnQA1XG/fnvG9TeCf+1/EnoWwpihfEieSn11hQVqC
         RNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXpJ0TQUpxsncyPGT+WrGCwDjQwyOyScZvMWbiWmnqQ=;
        b=xoVL6sosoXMpAk0d7FS4Z+vEoelMI15XCX3AkXtoBlli1XjACKn7SvO5vCqwyvVScb
         NmrkI6gQwke8tYzteF/t4M1LgT1iT6Ym9dbuUIGSbuWHqn4MvpUWrdtHbSq4vbQQYAZZ
         e1HXPcqRpMTPyjR7FwMItnSiPROXVWskM0MMcHA6w59ypY6rw6g7HfKjXWQOhTAjel9F
         kYZIWCBSGWVIT+22SGt0ia0rkpya0TLkZ0a2fSs3T4CtPjI72k2W51pGKzdX/vCWZjPa
         mxg4qfmW0zs0J3vRck7Z7CftpBVvAsSQky2u8+WFeySXvPxTDPjXZCZV/F4M8sBBrT49
         h9tg==
X-Gm-Message-State: ACrzQf2w+R+cE5n2UJffqihiTdn1Kzg3/To4GsoAH9Vs874UmygyHhZU
        S1Yh+A43ps8MOBwKsDbbx9aAHQ==
X-Google-Smtp-Source: AMsMyM4QZrngiG0bu3jk1wIYWPjd1b8g3GWApE0yPPTfPQmCWWgetB8x0HMeHLzSqxFQgwGjQJRn5Q==
X-Received: by 2002:ac8:1e90:0:b0:3a5:6891:3488 with SMTP id c16-20020ac81e90000000b003a568913488mr2315350qtm.49.1667574170399;
        Fri, 04 Nov 2022 08:02:50 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a240b00b006b95b0a714esm3203256qkn.17.2022.11.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:02:50 -0700 (PDT)
Message-ID: <dc6b70bc-c82d-9540-5cb7-e7a249359a78@linaro.org>
Date:   Fri, 4 Nov 2022 11:02:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add RZ/G2L GPT binding
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-2-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104145938.1782464-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 04/11/2022 10:59, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  sending to avoid bot error for the next patch.

Then subject maybe:
[DO NOT APPLY PATCH 1/3]
?

Best regards,
Krzysztof

