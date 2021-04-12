Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A735CFDC
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbhDLRym (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbhDLRym (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 13:54:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F217C061574;
        Mon, 12 Apr 2021 10:54:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so21681874ejo.13;
        Mon, 12 Apr 2021 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xZ2z/REQKDHpPpudGHJDtF+j1fU3msVI7XisJ2amc4=;
        b=UDvpB2a4GDnPlFBEkaSIRcfJMyWB2e4QNAnncdGeKlzcLUokn2c5mfaqypZdqPbzeL
         Mgf+FlNviP3AHd3CvAVEfJtY/q6YxakAF/BnOFglDXUoiyj+C7c32AEOOA9F0iLhEWRO
         CcdpFtRr/n/ZAKLasjDjtjzeWFNPP2j1akh81i+Rb3ZEI7wP+TrRBhduHH2pkpDyq7zi
         4XTOk0keAF9aQ6vSqLAt5uftZrp5PRIi2yZvhFsGniVbqN+YeLI5d+1Yz4p3anyOs87f
         UxN4fXHrpm3XJJZovc+HLoX4/DBDf11qcSXZG6UriPeE4PacTj0A2tfonbkOIIoyGX7A
         Tvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xZ2z/REQKDHpPpudGHJDtF+j1fU3msVI7XisJ2amc4=;
        b=g5CwhagksympI0i+7dDVwY5ePbZhBvqIgzuFnpxeMvO54YdA+LVLniRMHHmFyilaUO
         qaS4/L4xr5QBjocbc6juXOumcBj3bhMKwn8G8eaZMb5gS817ZKlQGdY5mti2LaGY5Cqo
         dvq1FMxzn8A15J56X1y419zqrXtxCrlJNUNZorO45HILNs9ROaU6LoXn1hSgkwUEqQwV
         btkm50g94+Qcevgt2+0QvYQI/uEJLTw+4V/jxIQtGjLzZwOXV7B5WXxb5njHFBjZPTOo
         WnSvnrPgLrBs7HWuuCgdwZz7z6a/ho0usJSkemFSEjJAAuN2uvz77n9Iu5OCDUr02DQh
         5iFg==
X-Gm-Message-State: AOAM531xolMQVLpCoxfeZpHGqqC0fKfLYXS0eJgvQ8QeWxB9xwJCo/vn
        cUorntbII/jkeL8rAs8Kpiw=
X-Google-Smtp-Source: ABdhPJwmIXBWKA7QOETds/BhD3661kA4UbZLfCHUrVwbpjensenk1YYVEv3gTJRh6So+ofnhWvdZ+A==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr2579867ejg.368.1618250062327;
        Mon, 12 Apr 2021 10:54:22 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm7472791edx.87.2021.04.12.10.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 10:54:21 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: add more compatible strings to
 pwm-rockchip.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        heiko@sntech.de, thierry.reding@gmail.com, lee.jones@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20210411131007.21757-1-jbx6244@gmail.com>
 <20210411131007.21757-2-jbx6244@gmail.com>
 <20210412150533.GA3898302@robh.at.kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <ba14a833-10dd-fc70-d6bd-70e8f6811ab3@gmail.com>
Date:   Mon, 12 Apr 2021 19:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210412150533.GA3898302@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Sorry, made a little mistake in version 2 with "rockchip,rk3036-pwm",
"rockchip,rk2928-pwm".
Please trash. Will send version 3.
By the change of schema for clocks and clock-names I add
"rockchip,rk3328-pwm" to the "if:", so strictly speaking v1 and (v2) v3
will not be the same.

Johan


On 4/12/21 5:05 PM, Rob Herring wrote:
> On Sun, 11 Apr 2021 15:10:03 +0200, Johan Jonker wrote:
>> The compatible strings below are already in use in the Rockchip
>> dtsi files, but were somehow never added to a document, so add
>>
>> "rockchip,rk3328-pwm"
>>
>> "rockchip,rk3036-pwm", "rockchip,rk2928-pwm"
>>
>> "rockchip,rk3368-pwm", "rockchip,rk3288-pwm"
>> "rockchip,rk3399-pwm", "rockchip,rk3288-pwm"
>>
>> "rockchip,px30-pwm", "rockchip,rk3328-pwm"
>> "rockchip,rk3308-pwm", "rockchip,rk3328-pwm"
>>
>> for pwm nodes to pwm-rockchip.yaml.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>> Changed V2:
>>   changed schema for clocks and clock-names
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 

