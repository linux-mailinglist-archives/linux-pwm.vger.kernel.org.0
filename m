Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187A8280278
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Oct 2020 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgJAPWT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Oct 2020 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbgJAPWT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Oct 2020 11:22:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31AC0613D0;
        Thu,  1 Oct 2020 08:22:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so7862057ejy.11;
        Thu, 01 Oct 2020 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HoIzt4luxNMRncgYUJgF/hrsLcD9YCcpUexpLitKXBo=;
        b=qdjH7Ti/HvtqGQpFSMw0Fsuw9Kj4+6ua8k1cpxYlw4o6XOhUGjBJsMLbeifphhZmpC
         rKCsU4vVJQRgVaVGelUyj+nqCXC2E4RroQm4WhZ1ufMwbMQN/g+TTcd87FPrHvpMuKC9
         63gZhG0GuorM92KWPIvfPuuV52275Dgqg/Wcsb5VmtKbT4SSsjYsjuCjRqXEvb9aIkg6
         xk9AfhPrR14Qw0ndG9I4JgE4i11LzsvkGp7mAG+1r5TPxxqsmde/zPQfdWEbhP4jqzxb
         Nv2p9sgTEhtDGE3g/Qy/x90kMPRfklKWDZqPH0o0qovQWxFlOP+DfTN4ITJvlTspULSZ
         f75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HoIzt4luxNMRncgYUJgF/hrsLcD9YCcpUexpLitKXBo=;
        b=ohlCbSoJ0coD02SyWbh/VG/alXonrlVialZZtqH6EwD6YlIJp8LsLF5UpkgiJOxjob
         tGbIvM/p35SuBq+arpbFWh0vrwNf3VxCY3KXZvSqPtKAUop/9D3NekU5VzaAe6kOPbus
         s4fVg7vAy1lEIQaxS0o9jbVdZTyfSgivZjwP4admB47Cx7WXrCZ+7HRnS16MniVOapOx
         UrGq64vsk6ahreabegv3IPBpP00fVvF4c28Fqs6HUeHLmRZQI6pk3Yojqmhaga1HcMhc
         n0Yc8uuAClDci/WckfyA7WoCyArpC8madrDiIpe3kN1hzOos7ypzV3k7TWJaGrYntHs6
         4E0A==
X-Gm-Message-State: AOAM531NJRhMMY7s2SRQXz6+FiIoZV9BvtIVE7YY8IUb5N5ksuSkQu0u
        wFwa1g+4gpITV25Fc9+XLfAI6380blE0rA==
X-Google-Smtp-Source: ABdhPJz4O60VU6XyO7VdMH1JS2bW36AWBbn9ny5fhwFCwnSYh7MdWaXsp0606UcP1kh2IXdIbs6Efg==
X-Received: by 2002:a17:906:14c9:: with SMTP id y9mr9095332ejc.523.1601565736206;
        Thu, 01 Oct 2020 08:22:16 -0700 (PDT)
Received: from [192.168.1.110] (abab147.neoplus.adsl.tpnet.pl. [83.6.165.147])
        by smtp.gmail.com with ESMTPSA id v25sm4266120edr.29.2020.10.01.08.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 08:22:15 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: msm8996: Add mpp and lpg blocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
 <20200929031544.1000204-4-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konradybcio@gmail.com>
Message-ID: <424f7b71-fb7e-fb45-c449-987ec3578290@gmail.com>
Date:   Thu, 1 Oct 2020 17:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929031544.1000204-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, 

Just a nitpick: the title says "qcom: msm8996", whereas the file being changed is pm(i)8994.dtsi. This also applies to most msm8992/94 platforms, as the PMIC was used there too.

Konrad
