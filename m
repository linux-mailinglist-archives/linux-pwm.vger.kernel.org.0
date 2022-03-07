Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F04CFFE6
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 14:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiCGNZS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiCGNZR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 08:25:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4A7D03C
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 05:24:23 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A5963F61D
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646659462;
        bh=TWixiBTEz7rcA6T3mO7kCyQ+X/3c1epPubayeGIJFlY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KhT2SXIg4hEZshD0ROWwDjCI37gNHAbw2WMQVMvMtuzA0nGe0puZlGxAdflf8uHq6
         0VaxoruV1JX5vR6H26G6nZ+YQ/4KMxZFnqx06dYSMFbF+io+Ekftt0sGuSR15tIMRu
         LtZ07KjyIkGbuN1rynr4K+B+LkGsE+IKrA/P+ah+Bzntqk7oojdMioqh7yicHD9qkd
         1ggj8Z6QNJxv3FrXWbu6Gz067qg+Q3mGS23YbP4MBtP17/QiIaGX1Y0f2pxe2Ac1bs
         fM4JdknGhTghCnhuedbvOrBuu7BFYr1Odk2gaAFTZnaAEWgSwqHLMeNbR/9/JcesM0
         201E5kjM/0F+A==
Received: by mail-ed1-f72.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so6236401edq.21
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 05:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TWixiBTEz7rcA6T3mO7kCyQ+X/3c1epPubayeGIJFlY=;
        b=lSQWonCvT9d6tgddHLkyKSmjtfTWbnc8h0l9l/TlkXWmHIux/0jKbECmrvmGvQPzrX
         mmhdgDZ4VOGYt1e7I7UZxem2AtA4D51NkJM30wyDu+aSMsUqJFa0M9puC9TVLaqmX4jV
         zFmSSGvwAUgQh+MgwMA3WDdYlehndQzaeCNJE0AX47gGVWVfb7ee5ync02QcEvIKmWAr
         xRubp9ObMO1xbbh9OTUwUnR3kGQV6SNYOzXIZ+FvLLu/swYsSJLbf392T87FcTM6ueSb
         73Wd3nuHPp10Z8uUzYAynnlGCCTD0MYIscLaHMEW/D9FaRgo4K0yirqXZ5Mpfxdyqu1s
         nUUw==
X-Gm-Message-State: AOAM530N/ZfCOOgd9OqJcJGzPeRD1hdMA+V1IMkfPwaq1nLtsTa5GslT
        FcuwdghBZdkgAgoNHlSnq0I+YLNR6/twilFPVXimp5n8/3S4JDwMF5ClUN+9rd/+sHPVaNwqZct
        PdmExXw0Jf3Y6EJ7OqXpv3ZqS4K+wsEEElTZI4A==
X-Received: by 2002:a17:907:72c3:b0:6da:b4d1:415a with SMTP id du3-20020a17090772c300b006dab4d1415amr8875404ejc.709.1646659461914;
        Mon, 07 Mar 2022 05:24:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXFDqly0FiEeOHc3R4bhal9n6ckTpaeqOa1nkibv9p5B+fqdjoW3nuQz7GB8OTn482i+rCng==
X-Received: by 2002:a17:907:72c3:b0:6da:b4d1:415a with SMTP id du3-20020a17090772c300b006dab4d1415amr8875391ejc.709.1646659461759;
        Mon, 07 Mar 2022 05:24:21 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b004162ee0a7aesm2787166edb.38.2022.03.07.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:24:20 -0800 (PST)
Message-ID: <a0b62141-0d5a-6b66-3238-eb5ba429644c@canonical.com>
Date:   Mon, 7 Mar 2022 14:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: at91: Add SAMA7G5 compatible
 strings list
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307130307.106102-1-sergiu.moga@microchip.com>
 <20220307130307.106102-3-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307130307.106102-3-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/03/2022 14:03, Sergiu Moga wrote:
> Add compatible strings list for SAMA7G5.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/pwm/atmel-pwm.yaml        | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
