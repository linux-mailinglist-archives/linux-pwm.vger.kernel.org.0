Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CA5F7B77
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Oct 2022 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGQbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Oct 2022 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Oct 2022 12:31:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4EC102DC1
        for <linux-pwm@vger.kernel.org>; Fri,  7 Oct 2022 09:31:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by36so6314711ljb.4
        for <linux-pwm@vger.kernel.org>; Fri, 07 Oct 2022 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U9a5uM36u3nBb7v+MEw1iJJRzXaqUzDiHE1Uh3pZM8=;
        b=STPnHQLS2fvQ35LAJ9/npRSwcbiSmSgpEfM52/uSR59aDHjnycccOfgLPwFde9unhf
         dQ/SfjpGdQfTKtYq5xHGBiyX8T8gx0vuYCknqam/LeX4Vn4GLTJuP8V9748gP/KjZJmY
         ZxpZJMDV5Goulj+vgk3GssA1IKZF4Rfb1LrKbEcHaObzpb7ys3cGrJV7jeVi5k8kkWQV
         yJdiGKd3dKCdyzDNKScYlYotsh3U+kOhQW3uSv6ANfXeJBmnzgo8mnYGmYntkGNWrFDJ
         aO9F4cDspwM7+EXH3rrQNuSDO939HfKGiAhLEcUa+qdr/4O7+eNYpZ7ZNMlbKVCCY3OO
         NTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U9a5uM36u3nBb7v+MEw1iJJRzXaqUzDiHE1Uh3pZM8=;
        b=0Y+9c00VCdK9mMs6JPlFOYZgfiMMpiNlWnAGbyslvjhA/gDJJYP4yaOSluN1OAXgA6
         hRRh61iROoJEi2ApXNQ9WD4LTzXFr15bzApu+DZa8Jd4zKrm5o08IbZoYN3oVFWtqxpL
         eAI6rJr11Yzn2XTx4+feWr8i4xOkpnf00xL5xwD35EVCYl1vIyNoqGnrAZcDU3Wbh8z7
         JSYBcZvcbvkmndLuBvLPxtHdoHVeAEgnJaRiGEaFucfsbx3fJQ+DC++0ooOjErKwAmwZ
         M5c2jt0630NR/2dR5sMjDAvdt+R6c3y1GMMCqGyp+780lTfk7TdYIc2b/XRxrc4zUiui
         lUbA==
X-Gm-Message-State: ACrzQf0gyrjrTT+j9D54Z6i+7lS0jYUEBVabCttg6QzUIBW/zqipYcHV
        H0XgMX8t10M+WuRerTJBABq9arxbRXxkJg==
X-Google-Smtp-Source: AMsMyM5uxwuDHpJIo4SlrFMzkT5YuKkbaKX080VRA/2aeSbtlPXKZuvsS0QR/0mS1c1Bb0xvYi+msA==
X-Received: by 2002:a2e:9350:0:b0:26e:b1:44e2 with SMTP id m16-20020a2e9350000000b0026e00b144e2mr2060977ljh.158.1665160272710;
        Fri, 07 Oct 2022 09:31:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o28-20020a198c1c000000b004984ab5956dsm344042lfd.202.2022.10.07.09.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 09:31:12 -0700 (PDT)
Message-ID: <dfda67a6-9adf-7497-be34-7c67eb3c0ff8@linaro.org>
Date:   Fri, 7 Oct 2022 18:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/10/2022 17:26, Geert Uytterhoeven wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4H (R8A779G0) SoC.
> 
> Based on a patch in the BSP by CongDang.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

