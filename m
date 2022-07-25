Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD55806B1
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Jul 2022 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiGYV2y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Jul 2022 17:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiGYV2Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jul 2022 17:28:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C424958
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g2so9659274wru.3
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LC1MButyAjgvhVwdTxySQfcTsI905HcQoSgMguQbeJE=;
        b=XIuER+QEkXsz5IY+kHqI2bwpSJoq2OQb3wKfqZ+BK5c7jPlBbRxlnq8nlkhnCbbYr7
         GnGARLlnY71J07XrmeQ0i0J2rmmeTLMs72YlQ6lgmd3IIulDnr/vBnjIrD+U0JRBIHxs
         zMY0C01JwXyk7ZRgo06AtAS9x9y0BAQ6zuDsCorpBiNWnLuqJfRLrKkYFwaElNMulpjS
         EG1BOqq9BIYRA0VRAJ1HjUjZCjws1JdY1aA3WCaNq3pCJJyPyiKVBvWBd2wpIz7bCwTB
         u33/Vm7cN9g8DiKlRpfkVYhe2EIjV6e8Kmm2LyHFV2up/PzCUl4tskP84B1W9bCYDlFn
         pZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LC1MButyAjgvhVwdTxySQfcTsI905HcQoSgMguQbeJE=;
        b=y0syszgHeW1MuTDkGoK1OuRYp+cPGLLsQinvaGXZV+/17WzHbettyLSSrmstodI6Tl
         D3xPwXOdODKp2GiZ2zakHUX/TsM4g64lpDpLQ0eJWnvSurxg4cUh1Ml+0FkfeTf7k3yG
         1dKV6oYcFflKNElX6ay7k+QcHytx/FJQLnhCPYoOCWmOpHfCUPB/RtxlEmo8SmQr00jD
         5lVZzuRqo3LTjMca+HkOndsMIZY/ujQXTDLcz9/YpanLwHzfFoyFQr7TXQksuaGaEXUF
         QmWrUJClox3TqAq0QboRckH6WENS4W6NjUQicDYC98ANwDRrw7ZrrncnyvMeLEY0g7qX
         S6bw==
X-Gm-Message-State: AJIora/01HQLhalbCfSvzGAhRJ+nujLaj7mlI1JFny4QfTjmRII03erG
        MKjal++84ZK50s94KgLGmBtAUg822mpKtg==
X-Google-Smtp-Source: AGRyM1uhCs8VsFP2JwWvB8LbQsi/wD2WmCWt2Rv2KajohyBY0rFeGaFvWA4ssIOieb9jtBGlLP6edA==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr8496954wrf.208.1658784457841;
        Mon, 25 Jul 2022 14:27:37 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b0021d65675583sm12624688wrr.52.2022.07.25.14.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 14:27:37 -0700 (PDT)
Message-ID: <0ad68731-1891-ced8-2a2e-682b50cc6488@sifive.com>
Date:   Mon, 25 Jul 2022 22:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-GB
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/07/2022 22:21, Ben Dooks wrote:

Argh, forgot the cover note on this:

Second version of updates for the DesignWare PWM driver to move it
from PCI only to both PCI and OF.

Fixes:

v2:
- fix #pwm-cells count to be 3
- fix indetation
- merge the two clock patches
- add HAS_IOMEM as a config dependency
