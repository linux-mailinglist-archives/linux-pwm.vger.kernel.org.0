Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384E5A9B19
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Sep 2022 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiIAPCr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Sep 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiIAPCq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2022 11:02:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04CA52837
        for <linux-pwm@vger.kernel.org>; Thu,  1 Sep 2022 08:02:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z23so15328022ljk.1
        for <linux-pwm@vger.kernel.org>; Thu, 01 Sep 2022 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bnyyJOLQMDavRkWLRZipZELRn6w/ZbL+BYoEZkO8mHY=;
        b=WpGYICj5Pt+Uin8WRC4W2vhxDlI4cvPygQYSssZqzyXZ34212z8zUnIX48xKDJqMHE
         v8a6NLx/FeMuWBsNAOkPeW0q0zLgN+dbKzgP4Z3x6nH93Iv5Rpv/vlbLBIKmK1pYUBjZ
         aMlsU40WukCTd0JgefTxqbB/Q7fLcjbzWzHRqO9s6ONp2bt1B7WRNFoBvKsGLw8xdLZo
         GGw7xBl//zf9V5EzYnQzlNWm8/MGAihvPs6RnKuphS1ocQ9cjDMQcEvvSRsyV7luBiWW
         Y512mT9AA7AcZ1aLbDKf+XGzR87fqqTslSWMfzweuEGDstrx4rNEGtnbJLcy2DSWFHAe
         JCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bnyyJOLQMDavRkWLRZipZELRn6w/ZbL+BYoEZkO8mHY=;
        b=icBV40DRsxk838gvkBSAlRMz+iupiMFj9tT4cNDXdXJ+bQ19YSb02DU5Np9NLmudwB
         3BbIfJ6iKi1U3UewdlACfSspJYvNP88dvMkE3uOvY0CxyZdvbJ87dNCkXUo1OB9E5hgh
         96nDcnRCh0y5yoRZ6AfuBKNjt+8+8FtrviWIy8Ysc5BGeAjSEuGj4UJNmNLHIhFAgc46
         fRIfTPbyyudqe5SJTZ1rmNBJ+SKT0bv84dYbjuPfPrwk0dFto2icmUhXD2dnUDebt7Cs
         /kE94dIPcinbToW0QJJ3gyhZqn1fNzZb8Ai4NspvGoRGyjPt4mcZM4EnSG1rYDetCHNl
         E5VQ==
X-Gm-Message-State: ACgBeo2wfjYanJetQRmdgk8ELWBxaneg7VwIyAcKyWvKH6Y+o/UVgfma
        Fk98uHaE4bfBXYDNv2x8tOxEHg==
X-Google-Smtp-Source: AA6agR6gT8R6Q+X3W/6U7AKKGJTV4+E5AaniYtSdiEHafWUuuCSs8O2SVPBq6jkgGrazxSQszi3E7g==
X-Received: by 2002:a2e:b5d3:0:b0:267:4da0:ce3b with SMTP id g19-20020a2eb5d3000000b002674da0ce3bmr3645047ljn.420.1662044562919;
        Thu, 01 Sep 2022 08:02:42 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512370e00b0048960b581e3sm1396263lfr.8.2022.09.01.08.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:02:42 -0700 (PDT)
Message-ID: <745a351d-4418-1233-8b6d-c65cc6aee239@linaro.org>
Date:   Thu, 1 Sep 2022 18:02:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901135523.52151-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 01/09/2022 16:55, Sebastian Reichel wrote:
> Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> on a rk3588 platform.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
