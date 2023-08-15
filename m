Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566B177D4A2
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Aug 2023 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHOUuu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Aug 2023 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbjHOUut (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Aug 2023 16:50:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95722212F
        for <linux-pwm@vger.kernel.org>; Tue, 15 Aug 2023 13:50:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-319779f0347so2023946f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Aug 2023 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692132627; x=1692737427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNzhnTa2Xplp/Tkji9CmBI7UUP7vxyc/BEYibHP6fMQ=;
        b=tCXyosyVlqXxvRWfCD+OFHX4TXkXgMKFq+2qFzL27vxvJSyN2yC59ia6FGGS2ad+eS
         U/6Af8dAP+oqGaUe4MRFvumk6anbpxkuAXtZF8K7B4cbRMRC/MWxsrjoR3AjvXSyiDDi
         KVXodl7Rk2g4XXHnaiooEUfR0FBK+i5B0hiNUpkHFrPzMSZ6mM5nH3fTtgqL4gOP+xiv
         us1iLSUkMgHp0+vFzadyWMSsnERAURKrBNk4RX/SS5qfRSH0mDr7c+L6KlB3Re5THDT+
         4iUlAbX3fOPqcpMUPaFl4GIoSsPeIFBa/8+Sxu60vV/4RKz1EOIVg8a82kMGE7k1HATK
         Zy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132627; x=1692737427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNzhnTa2Xplp/Tkji9CmBI7UUP7vxyc/BEYibHP6fMQ=;
        b=c/4yAycYO+Rm9vrbHv/a+bEp5YUYSxODCqKc2ASeTQ0cuft2C8vsXnsbo9GkjzHz98
         iE/5ZH6R6KlXmaFEa0keyBVDx7rEOKPAVoFkpU7CyYvJ/64yH8l6HMPVJaX8xCqoE9ib
         xP5PLKO9RuGkPM+UxigBaZNq4+HqskbvsRMwHX5HOl4Zm3iAQ+1N5yGZ3BLS3/z0Mkfx
         FTf7oT1w8x7qzHglWYZ6JPqa1Ftf5enu6yHGOaDEQy2cemZ7KS2fuA+X9u56rQBN7E6W
         TDVS/vBt5sh8ndBJ8R6oQATqmvV3jfI0Erua91tHx54Q4NUq2LCs7fFEvH0XuG/tx9KS
         pcwg==
X-Gm-Message-State: AOJu0YxZz00NMcibEL1kJkyOx4vZpKr/ie3KEZpt+XMxIGJOjFO73H1z
        tzAFHSSM1uGv/2KSAyeWs5gihuLmMSM8FSmAFmA=
X-Google-Smtp-Source: AGHT+IF0wXBsnPoEuKcnguUYJu/0ii7qC8GDdNixBFOmOnFlT/R385o4ZmzsQLucS1IJNlav7GC30Q==
X-Received: by 2002:aa7:d8c4:0:b0:523:35ce:bf50 with SMTP id k4-20020aa7d8c4000000b0052335cebf50mr11399349eds.23.1692132037464;
        Tue, 15 Aug 2023 13:40:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b005232c051605sm7184074edv.19.2023.08.15.13.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:40:37 -0700 (PDT)
Message-ID: <97e58b59-7b02-bfb7-9904-abfcff6f1005@linaro.org>
Date:   Tue, 15 Aug 2023 22:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LPG PPG
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230814235918.10396-1-quic_amelende@quicinc.com>
 <20230814235918.10396-3-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814235918.10396-3-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 15/08/2023 01:59, Anjelique Melendez wrote:
> Update leds-qcom-lpg binding to support LPG PPG.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

