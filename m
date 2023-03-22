Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8C6C535A
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Mar 2023 19:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCVSMQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Mar 2023 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCVSMP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Mar 2023 14:12:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961364A9D
        for <linux-pwm@vger.kernel.org>; Wed, 22 Mar 2023 11:12:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so76482826edb.9
        for <linux-pwm@vger.kernel.org>; Wed, 22 Mar 2023 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679508730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puINCtdjibA0BYbSrHoIfwhwVYXsutPsDY4I7ib4bzM=;
        b=J7Ks+YQakaDhUbwe8fWKUNhebNRsFdwb/Lt2TOCFMNg+p9GiUx1mGrdm+ePPnPiToA
         joVvFXZ9IRD5fpifPU4c6U+tOqPfs4b5/hFXOUQXGaHUMdrpDnzHgUfsLtoggBWT7Xzw
         kmaFq+69ED1xC9xB5ZfCJha8yF5WS0xB1wIu9u74lHB0WBIRKArwWjkMY627UXPANUU1
         uP8HarJiZUN1dCQqJoR+JCZ26kewvnKyt+h1HlQKFxeH5+SHm71Gdcsao96kZGCJ+d3Y
         nI00zCQ86niFQuFoR/A54EHftmRZ4p7/FmMiiEStiSS+lFIH+6h35+46PBejBJJrwfGJ
         g3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puINCtdjibA0BYbSrHoIfwhwVYXsutPsDY4I7ib4bzM=;
        b=GHg4p1muC0xcY+Yy+1+VBoy+KOcK8XDaSBBMEGhUDlpVoyQ2t5r3g75QqLrpOn16vI
         ejocC2YJx8OVxQY83BgKJC/PqO1yAjL5BY/DWe8/qp0H/0fmkgnuJ8xNH+MW4QqO9/i9
         30hr1U9VTXYxTTYbGlOoiM5Qahw+ku599PeFwpuD7qlPTTbMuqxkFWG/DmXG7Sh3UPgd
         WO0NXcXvqeP8ksbp0Mhq0l4fxVR+eva2Td4oadjR1snrGRlXc7EQ3Gez2U5FI8wk5PjH
         72HzbkGEOd7AlPnmyJ6/Vmm0oixgeq+PrzjQnAuYas9f0GzsGNFpgU1MHyyPigbMsrK/
         1yRw==
X-Gm-Message-State: AO0yUKUTTKwCrsA93knM7Iz0HlPMPnKfDO/gnN4e0w7b1CXEOmqZfZ8x
        ytFMQ5NqUFYQpO+dJan7xl3mNw==
X-Google-Smtp-Source: AK7set+vT8b6vldZsA+TIPblzpsRJ83hqYXESjC2wwa3hOGcErQIr0FtnbAyQvVwSpd8ejjf0q1adQ==
X-Received: by 2002:a17:906:720f:b0:8b1:2bde:5c70 with SMTP id m15-20020a170906720f00b008b12bde5c70mr7719669ejk.2.1679508730430;
        Wed, 22 Mar 2023 11:12:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b00501dd53dbfbsm2681070edj.75.2023.03.22.11.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:12:09 -0700 (PDT)
Message-ID: <74309bed-e46c-69fc-e0c7-6d06c30fbc4f@linaro.org>
Date:   Wed, 22 Mar 2023 19:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
 <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312154210.ovm54x2qtcv7fp7r@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/03/2023 16:42, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Mar 12, 2023 at 02:51:19PM +0100, Krzysztof Kozlowski wrote:
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it might not be relevant here).  This
>> also fixes !CONFIG_OF error:
>>
>>   drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hmm, I wonder what else is required here to trigger that warning. On
> amd64 I also disabled CONFIG_MODULES as otherwise rcar_pwm_of_table is
> used by
> 
> 	MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);

1. x86_64 allyesconfig, remove CONFIG_OF
2. Build with W=1 (this was GCC)

Best regards,
Krzysztof

