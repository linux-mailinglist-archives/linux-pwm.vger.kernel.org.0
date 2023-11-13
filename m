Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48EC7E95F9
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Nov 2023 05:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjKMELV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Nov 2023 23:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKMELU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Nov 2023 23:11:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B5111
        for <linux-pwm@vger.kernel.org>; Sun, 12 Nov 2023 20:11:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso2375882b3a.2
        for <linux-pwm@vger.kernel.org>; Sun, 12 Nov 2023 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699848677; x=1700453477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HF0aBU6FbocjbpakYgNW9pUsQRPeD9mF2KZkkFwxhnU=;
        b=PNYqh5xYvKupu8TcIeUaoG/0vB8qFKST1PXyBmJWGkFoLB8ElwvyCZUIaMEYJQIhII
         qYPnTmjhAPCu5zYWw13ju7/16n6lsaaGgvQjiiW39iUksN93aPF/5JTBLjq2ttI+No2t
         Y5VwAtKjCKHrGFVtqCmpMYEgV3ZUcUVxZRn65Zl9+jcbxFSESSpuyBCv3jZ2IpXj+QxA
         imE8XggrI5RCOLEp5gfJUg3M3FSFOov++OneiYgLKKqeKb2fMQFkw1W37juB294Guf+9
         BhVBy68vsbr7Pl25MXCSVofQJZ7kmxHDA9eTgUU99MidukQQdDF5Z8E9cBwuV9+pVP0t
         E0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848677; x=1700453477;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF0aBU6FbocjbpakYgNW9pUsQRPeD9mF2KZkkFwxhnU=;
        b=DJakjBCCiI8A0tvkR7ZMyKB/D/9z49CAsk2Z0hjqRwjtqrt29vYL7hxtYjjEgaja2b
         QOqwJx14cfd1BVR3XIOTJ5JUo/BgOpnzReqJs9vuXK59S/hpbOEZsHqgkhDOqbBw5d6P
         Z6i9n/QCWKw7O78qMIDnUV29p/1yrZ4eDoIihe38tda3xFpC9gKKHlyCpJckzqbGFcKL
         A50ppX9bNoYVmpZPdwBOB6KGy9Wc8i/uY43iKYJadxf5zeYONHjaJ0aVF7jGRw2qsmaN
         wpnCK/c7Lr4spH5C4DXPrirfTrd+2VeUQifX2+dWImG6J1Lww2L4VN70zAMnjRh1ywl8
         WJbQ==
X-Gm-Message-State: AOJu0YxotY8DtmJK9tqScc/SrzPznNtUpe0kFap4yKyXF9OicVcjrf3W
        G++ZElnPpixunc0gZmcOFaJEdSW4G1I=
X-Google-Smtp-Source: AGHT+IHrSP4AkPsWxlQWBYIFYIFpK5VXdgdiO1OGhBQdPGnYEagtDKN+EmsLWuxeZnheuLQOS3sgxg==
X-Received: by 2002:a05:6a00:1bca:b0:6c3:5f49:6da7 with SMTP id o10-20020a056a001bca00b006c35f496da7mr6724070pfw.2.1699848677286;
        Sun, 12 Nov 2023 20:11:17 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:121:ee5d:d858:67c5? ([2600:8802:b00:4a48:121:ee5d:d858:67c5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b006bf43e5619bsm3103253pfk.195.2023.11.12.20.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:11:16 -0800 (PST)
Message-ID: <29b654c4-010a-406f-bf47-8fbdb6a65d18@gmail.com>
Date:   Sun, 12 Nov 2023 20:11:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] pwm: bcm-iproc: Simplify using devm functions
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
 <20230929161918.2410424-2-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20230929161918.2410424-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/29/2023 9:19 AM, Uwe Kleine-König wrote:
> With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
> dropped from the error path and the remove callback. With
> devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
> callback is empty and can go away, too.
> 
> Also use dev_err_probe() for simplified (and improved) error reporting.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
