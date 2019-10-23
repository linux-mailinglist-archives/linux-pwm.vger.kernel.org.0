Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCCE247D
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbfJWUVp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 16:21:45 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35085 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733302AbfJWUVo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 16:21:44 -0400
Received: by mail-wm1-f49.google.com with SMTP id v6so281458wmj.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2019 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvlbyXuPyFTwAied7QnteSmnSAks0nnDSQo1KMTiaVE=;
        b=Xj42kaG68KB2VqgfIb5WaldkwjZPYh7u9UuIqn13LK273eVvgXA00Y6Cswp8d1l7qz
         T4/UEKKv7M1R1vyNyt7A7scnybyl1yjgaLmKbryMQECyRBLKXIo5TbE8jP6iPxa6Lsp1
         erAhoFjfmB25XdzGmrcYkhnwlrc9jd7YJADBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvlbyXuPyFTwAied7QnteSmnSAks0nnDSQo1KMTiaVE=;
        b=LiAw1emA0BuaN6bObS9ND+zvnetwMOcLKncn63TJA9yKdNxlKvtsTzNb5Xnjos/tg9
         Eyi+C0efoRYthtf+ocrIQI1/9zxNWv8UrAd819YOKV9v6IxK6rqtlClZh2l4Kiug6DVA
         cS3NJZ1NDU3sOornGdIOvse/ifylqLH7k1kGC90Nr9Huf5XfkbINuglDpNvHZtAh8XNU
         KVo61W6PivUq5C/CFJ8TIYz+j60Jbip4fPF717tPhLYvHmKMg097LXy+eOyQS6irc8fH
         +q4XZcJmIxqOMYpNzFUwA0F1RSRVO8t70RZbOlL/60oGcURd5RYKsgc2fNQBrSypgH6c
         vT5g==
X-Gm-Message-State: APjAAAVBRkS22eeoAGgvHPir5a4OzxnJfPjP2TtTIFHQnPcwvSiMyAQS
        qOQhSByJlmk5aygmyeQe36M4LQ==
X-Google-Smtp-Source: APXvYqx/TQ4n7MgqmhhUNyCHVlVoWUDwk6UPKxs7AhubFXQlhlXDfD+59nnAXt9e3Fhnux5l8ALyIw==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr1570137wmb.95.1571862102054;
        Wed, 23 Oct 2019 13:21:42 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id v128sm365873wmb.14.2019.10.23.13.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:21:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] backlight: pwm_bl: fix cie1913 comments and
 constant
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-2-linux@rasmusvillemoes.dk>
 <20191014072710.GE4545@dell>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d716cb92-4d72-f661-2ef9-2771846569e8@rasmusvillemoes.dk>
Date:   Wed, 23 Oct 2019 22:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014072710.GE4545@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14/10/2019 09.27, Lee Jones wrote:

> Applied, thanks.

I'm not seeing the series in next-20191023, should it be there?

Rasmus
