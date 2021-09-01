Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573513FD70A
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Sep 2021 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbhIAJnZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Sep 2021 05:43:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49642
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243021AbhIAJnY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Sep 2021 05:43:24 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C60E340190
        for <linux-pwm@vger.kernel.org>; Wed,  1 Sep 2021 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630489345;
        bh=Y3RQ54Zm5OFe9AQSuUGmYtHrFrafqN10VZzfx08OW4s=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ptEwrW+rV4ihnJssfFSdhJjffO4KlZ3CErO5I2fNT3tkhVC/nek8aIRQEP4JMgZOv
         LoreR12QX0VFgQhAw5Ex7ei7zG8yeEPQmYOt7OfColIUPDGIvkpqjyd+2JtcTJFQB4
         UiAMRZ91Jv6ClulUOX3R4vZmXXwlBlS80lnM9yz6/H43onTRYY5GiT5rqyOnLUjeQ0
         hT20eYMNBeRE8MqXRrmv8z7+OHzqWFvaipIlirOgSo3VPvv4YlhcLHYcYqO1EtLWQw
         rFYGztgDiKx4gE1cxvXokwANYTKuaor2ZEkp1g0yXyk5JTLUQL0gpIXRnNreE6MSbF
         h/x52xI7FI/uQ==
Received: by mail-wm1-f70.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso2594867wmx.0
        for <linux-pwm@vger.kernel.org>; Wed, 01 Sep 2021 02:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3RQ54Zm5OFe9AQSuUGmYtHrFrafqN10VZzfx08OW4s=;
        b=RPnsEG8GYFokkhIdC1HXX8M2jG3L4WSxY5DNEI3I4JoT2e3DMzCOaph/ldWicB2Vsl
         HkgV9UbVnckU6xuiukuke39V1ySdVwacLuAXDSqm/VGydOl317Bn7cPmjftmTTHAsrR2
         2vvUo7EMww/mGa2v4ecbH4EoI2BUZ0mvKd7cKX4KdREEIrKJUpYain4r+EE6B99LFrFQ
         gw+fifG+r2qASVPUKT3bpTXEBm+0C7rOjZljyCCk+nhST0y/LmXEzQqyAa6zX+aZe+Bn
         pjc9r2pzW8QSXdjYWQYBKB05oT2+2mla0ve9TSJd0+oKwt4e480x1aIGDiEz3D3mtQhs
         pmzg==
X-Gm-Message-State: AOAM531EyBCYo7yWW+3UyYRLYYk2rVlsNBThHTrxSCVNzCLXsGnqnNch
        ER8tGCLuCKcLNs5BT2350YTddU1dPM2039qJeGTNaGLp4dkhwNzMs+kBpiJxXuz5OwGBc9uSrwA
        bJJHlRtkBun+Fe347EBExQUuGrHrV5Kh3MZQcjg==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9005598wrh.314.1630489344171;
        Wed, 01 Sep 2021 02:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR0Z0kzD+pLwVC4xGiQJns7caEYN8rRGrEFZPzMKL7gxFfjGtfCH/P6c84n/PyVciuzn525A==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9005583wrh.314.1630489344007;
        Wed, 01 Sep 2021 02:42:24 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.172])
        by smtp.gmail.com with ESMTPSA id y1sm5096157wmq.43.2021.09.01.02.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:42:23 -0700 (PDT)
Subject: Re: [PATCH] pwm: samsung: Simplify using devm_pwmchip_add()
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901054230.29678-1-zhaoxiao@uniontech.com>
 <79e46f2f-c3ed-d187-2553-e64e0aac4c13@canonical.com>
 <612f43cc.1c69fb81.205fc.d94bSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e4d04494-8c49-b1c5-c0f4-165fc59f516a@canonical.com>
Date:   Wed, 1 Sep 2021 11:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <612f43cc.1c69fb81.205fc.d94bSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 01/09/2021 11:11, zhaoxiao wrote:
> Thanks for your advices, This patch is modified with reference to the 
> patch that has been submitted，example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=66a03c4fd9e95e192c574811a1f4ea8f62992358
> 

The patch there looks correct, but you cannot apply one code pattern to
entirely different code and hope it works.

You reference a patch in a driver not using drvdata and having only
pwmchip_remove() in its remove() callback.

Now you apply it to other drivers and:
1. Remove drvdata even though it is used,
2. Delete additional code from remove() callback.

Especially the point (2) is a proof that you don't understand the
fundamental Linux driver model, so please do not convert code into
devm-like() before learning it.


Best regards,
Krzysztof
