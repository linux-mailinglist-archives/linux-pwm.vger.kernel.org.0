Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122B7511B0
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jul 2023 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGLULs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jul 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGLULr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jul 2023 16:11:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4162113
        for <linux-pwm@vger.kernel.org>; Wed, 12 Jul 2023 13:11:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3110ab7110aso24096f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 12 Jul 2023 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689192700; x=1691784700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxj0vkKKD043p6PHtWv3KkxyrVuCumGrpEKjLxYyWJQ=;
        b=nnOJSC6xtHB4u5pCaZlk7uAp1eT3XU5je1VAzlkF6Vx52tz4YCBE6or4dtGPTXb1QI
         ENoIbxBCkQRdaTd9ySKijp9AbYUSQ+miYOJyXZFv41HAaCRiieTP4j/mi6QJntvokFWe
         UUeMlwqlagtjaAJ9X4gj9j+6Lk7mfEY+wrYLV7YYImdbVNQmRMDE1URwWD7BW8bhyEbJ
         1NNNraeHrZnYHBSUAx0hdIyampNie/FR8i69RREFAbv4r/AmFmBXQPLC2WDGIK5VSwqI
         2ff5phLH+ZlbQ95x3OWEfEQ6dumLOmkkH169uiKB65YXw/b6QecFdq4tQV0ppcwumSYf
         l8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689192700; x=1691784700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxj0vkKKD043p6PHtWv3KkxyrVuCumGrpEKjLxYyWJQ=;
        b=hIgzc/pdvEsuhKA/5cYna8ctwGOQuj5i4YED9PJXPACUoTfw3cFy5m3ytTUPqkU6/s
         F4mO1xtzItYOHuqxELwJHsyX30UpdsWUEZUowtc+9SioSqqRvlDmX5bMqb+PkE/sdemI
         affemj9aoJHgR39S/HkxQ02cWYxg+/MB9sN+/UADlwcNJkFWtH8sO+1jk762kIg6HGXm
         ElGD8rb5gSDWQTi3foAYwLEV2sHXiVfmS42SuYaCeXqXaFZcTpy2dF6stXCpyJ5PPKD4
         Nn6mjBJXcPIevGWh99BlYSTWkze+zt1GPn83DTUokBICM4mbmjXkPyWoy21Q6c+uGVzm
         OeTw==
X-Gm-Message-State: ABy/qLYGtv83FcTk6fACYvzIJARJ3gX+3y3RJG7kBLntEMYahEXHq6w6
        lcKK8qk0sKXKQ/igbcXkGA19jg==
X-Google-Smtp-Source: APBJJlH+0TnOotXAYGx0jlKszWQEPcLmBqrbTs+ppgRqQnCJSOcv3BjmwS9Xi3KE3eQBYYJyEmjIng==
X-Received: by 2002:adf:fd4f:0:b0:315:a74c:f627 with SMTP id h15-20020adffd4f000000b00315a74cf627mr5448716wrs.16.1689192700077;
        Wed, 12 Jul 2023 13:11:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qo11-20020a170907212b00b00992b0745548sm2935867ejb.152.2023.07.12.13.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:11:39 -0700 (PDT)
Message-ID: <7ecf968b-45b2-c6b7-86a7-8d8caccf5002@linaro.org>
Date:   Wed, 12 Jul 2023 22:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Rob Herring <robh@kernel.org>, pavel@ucw.cz, lee@kernel.org,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
 <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
 <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
 <71e1f36f-8fd8-9d61-d563-577d4fb54f10@quicinc.com>
 <69c01f0f-4eb0-bb44-a238-5c9ce5beede9@linaro.org>
 <CAA8EJppCSnEg1GjX8CavxRPiiE19JwVAOTspjWJR-OzdQMcu+g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppCSnEg1GjX8CavxRPiiE19JwVAOTspjWJR-OzdQMcu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/07/2023 16:35, Dmitry Baryshkov wrote:
>>>> Rob asked you - "Is there more than 1 instance in a PMIC?" - and you did
>>>> not answer positively, just mentioned something about drivers in
>>>> downstream, which do not matter. So is the answer for that question:
>>>> yes, you have two instances of the same PMIC differing by presence of
>>>> PBS and other features"?
>>>>
>>> Sorry that was a misunderstanding on my part.
>>> Yes, answer to Rob's question should have been "We have two instances of PMI632,
>>> where one instance holds the pbs peripheral and the other holds the lpg
>>> peripherals. The child node for pbs is needed so lpg client can access
>>> the PMI632 regmap which contains the pbs peripheral."
>>
>> I guess I miss here something. What is "LPG client"? I don't understand
>> why this LPG client needs existence of PBS node, to be able to get the
>> regmap.
>>
>> PBS is a child of PMIC, so it can get regmap from the parent. What's
>> more, which DT property passes the regmap from PMIC to LPG client?
> 
> There are some PMICs which claim two SPMI SIDs. For such PMICs, each
> SID is a separate device, so it is not directly possible to get the
> regmap of the other SID.

OK, maybe after implementing all the review changes - including dropping
that singleton pattern - this will be clearer. Please send new version
and we will discuss it from there.

Thank you.
Best regards,
Krzysztof

