Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD0185C51
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Mar 2020 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgCOMWA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Mar 2020 08:22:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52938 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgCOMV7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 15 Mar 2020 08:21:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so14624054wmo.2
        for <linux-pwm@vger.kernel.org>; Sun, 15 Mar 2020 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vha27SiAYzAhcDNBs+Dl9n27oWyXGNvtt3qs0cPd6sQ=;
        b=vdx/AWpbJGf6eGvcUWhRBV5AGujIONlqn5ljlh0AgQ66Phu9FKyLyrmWy/dwSOhasL
         JiPWXsOZNSIAh8A1Wh1pWA7qgDOjt1EFP0EB/r+auvvRyG+xVTnXol7hnamr1lIZwvOe
         HaadraWXgolGcPtFXWLhEaD5NJbjlJh3oMnL9DOpFK2M2jU/D338nlC9jpdyrrfmIAxs
         S4EbWrB7Vlkjo1cKRTeq+NbcrV9RNCiXTyvKOFpxfuHfRf4f5FMYoFOJ6UA0BBdnFb/m
         hR82zI96c6qAGYF+9oq2mSz+7ZVkMPxoixusUO2LlJg3Ow3eKhlB5oIVPkHRHQcP5AYl
         BbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vha27SiAYzAhcDNBs+Dl9n27oWyXGNvtt3qs0cPd6sQ=;
        b=dVag2eVm1zMTIcBRks1poGwbu9Gc9WzYK5TZ98Z5xQD8jvg1FPtX/OFnFQlelWqgh3
         ydi9b5wtyUgrRF7FkGSARJlBtzQo90OtiMLGTcBREjNXUDYxyEN3tWMpMb3cvoaVAlkV
         1H3cWA4zO/6VWq2ntK/YSDbwM48tQYSiLR+AkznHggG//+b0N4VqNvTrolfabY0fNWt3
         rpUmlfVUhNCcC17ZSrWWG3ZMAoDMDIB643kgu1c7JGx8vxOWM7lvT3VJxLDAvd21mQyH
         TsR097HAbXpnZ60UqmREUL8n+ZJW05JpkI9nVyC9qmDEJdOzYEsEYGZ1x6kXq77ainWG
         2kdA==
X-Gm-Message-State: ANhLgQ2fdASs4ttXCbel+CWlpgp+sWbCH/89KKDTanN7e8gs+E8xgu6d
        kAcvzOOeqUP2GYN3MTKg3SBeDQ==
X-Google-Smtp-Source: ADFU+vtQnU95n7qy8u75UCKhpXx1uwrD1M1UBVCsAjszEJYzX3P1D8bBHGSvVEKd+7LWflB5zO4tYg==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr21714742wme.176.1584274917762;
        Sun, 15 Mar 2020 05:21:57 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:9df:5498:f5ea:8be8])
        by smtp.gmail.com with ESMTPSA id v26sm7733803wra.7.2020.03.15.05.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 05:21:57 -0700 (PDT)
Subject: Re: [PATCH] pwm: meson: Fix confusing indentation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20200314113524.23031-1-krzk@kernel.org>
 <20200314214347.dun6ith5zamaa3m6@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <658d2096-8a2d-7cd0-b4fd-88f4516ac7a9@baylibre.com>
Date:   Sun, 15 Mar 2020 13:21:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200314214347.dun6ith5zamaa3m6@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le 14/03/2020 à 22:43, Uwe Kleine-König a écrit :
> On Sat, Mar 14, 2020 at 12:35:24PM +0100, Krzysztof Kozlowski wrote:
>> Fix indentation of return block.  Smatch warning:
>>     drivers/pwm/pwm-meson.c:139 meson_pwm_request() warn: inconsistent indenting
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This exists since commit 211ed630753d ("pwm: Add support for Meson PWM
> Controller") in 2016. Added Neil to Cc:.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 

Missing

Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")

With that

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
