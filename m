Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721373CA5E
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jun 2023 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjFXKBl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Jun 2023 06:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjFXKBk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Jun 2023 06:01:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA5E5B
        for <linux-pwm@vger.kernel.org>; Sat, 24 Jun 2023 03:01:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso473629166b.1
        for <linux-pwm@vger.kernel.org>; Sat, 24 Jun 2023 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687600895; x=1690192895;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoNtG/v3rSRDZ59/+rWTCWbhHlO7e/ovNSLpKbH5pNc=;
        b=m8AOR415JnoiVvUV0Hgcuqn8vZN1s7R8ygno813ELvu/3g+Nk/lO5eDNL10lOYui2F
         DEsWcq3+4mMALwPmsYjgok7nGDROv9C3IpIvNvoledT80kT6MIB1SEzvhOwJ/Zj7oIwO
         iF5KlQ89AfdeWx2ZIWzYdNVSxwDo9EU/9m94P8kHmaBWpkTvWL3hidjAXPUjzNqO7fB/
         wNBXx+ZPHQDcCncqz1nEPNysSTeCwkjjbnMhQMpj2qWHM09VuJswSbBqnK7i5G4n0ChB
         l8gIRK019sBaCXw7Q77Fvm6VT4pPA7Tf/7Fnv6J5j6S517Kb4m2stzUXJQEE1R2jzf5r
         h4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687600895; x=1690192895;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoNtG/v3rSRDZ59/+rWTCWbhHlO7e/ovNSLpKbH5pNc=;
        b=UuUmvJA0M4K1XB0yzYWCEBvCxg6aLmUiGvnfVi84V9FsAIEdSr0v83/+ccMT7asnkb
         fC/gQphJHO51CQqAlpB8jpeqrzZwNX+WHwbgTTsiIfIqo4MVzwmV9Ppqp4pzsf4KpeGQ
         c7hVpPqhvu2U6paG5u0w6UjEjONsnLJta6k/ckb1FE5YvYwRw1/xxts2ZY/rs+QyAQmk
         Y8d1XXy69Jv4Tdr2MsT2vJDJFUiD7LkPV+K7pDMMpM9QuTFQQxIIRMKuAVyrJ0umSAEs
         Jtdh3u6wFY898bTS2mxX8EzoZNiDQnOPBeYQmRX/dcWwH/ovsZYsqnmGzCifdKns2ERf
         9ImQ==
X-Gm-Message-State: AC+VfDzQwu23aBMSbFBYUf+RCgh5rrcNsgGcE4BbGLOxHlZiIq4gSkPL
        c1QZInLI2nG25LSamCHGDEGx2A==
X-Google-Smtp-Source: ACHHUZ4cmRPeuk7s2kJB2ZGix4uXIvSI3gqOpqolH/OivtCf/p3kw8zbJYCJwBIi2UWVx5RBGWOuvA==
X-Received: by 2002:a17:907:2da6:b0:988:15f4:fdba with SMTP id gt38-20020a1709072da600b0098815f4fdbamr20482429ejc.14.1687600895515;
        Sat, 24 Jun 2023 03:01:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id mc3-20020a170906eb4300b00988cb67ee1asm717534ejb.55.2023.06.24.03.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 03:01:35 -0700 (PDT)
Message-ID: <3272350f-73fc-f6b6-326f-1b9d7db75758@linaro.org>
Date:   Sat, 24 Jun 2023 12:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-4-quic_amelende@quicinc.com>
 <42126265-75b6-83be-c3aa-ee2a16cb26dd@linaro.org>
In-Reply-To: <42126265-75b6-83be-c3aa-ee2a16cb26dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24/06/2023 11:55, Krzysztof Kozlowski wrote:
>> +/**
>> + * get_pbs_client_device() - Get the PBS device used by client
>> + * @dev: Client device
>> + *
>> + * This function is used to get the PBS device that is being
>> + * used by the client.
>> + *
>> + * Returns: pbs_dev on success, ERR_PTR on failure
>> + */
>> +struct pbs_dev *get_pbs_client_device(struct device *dev)
>> +{
>> +	struct device_node *pbs_dev_node;
>> +	struct pbs_dev *pbs;
>> +
>> +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs-client", 0);
>> +	if (!pbs_dev_node) {
>> +		pr_err("Missing qcom,pbs-client property\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	mutex_lock(&pbs_list_lock);
>> +	list_for_each_entry(pbs, &pbs_dev_list, link) {
> 
> It does not make sense. You have the reference to the device, so you
> have the pbs (via container_of). Don't add some
> global-list-lookup-functions.
> 
> Look for example at Abel Vesa's ICE patchset.

To be specific:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/ice.c?h=v6.4-rc7#n293

(+CC Abel)

Best regards,
Krzysztof

