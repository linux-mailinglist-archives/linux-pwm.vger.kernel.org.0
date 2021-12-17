Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82527478F2C
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Dec 2021 16:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhLQPJ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Dec 2021 10:09:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57586
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237965AbhLQPJ2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Dec 2021 10:09:28 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3B663FFD7
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639753767;
        bh=Ekcv8bNIXIYPhjro0Nb278CmOGUMMLIkTcaAs3AM2AE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DHG7jnOPPBG1khV/ZT2NA77WyH5DyLz4lsrUhJG1wQf/ozsqqEHbed2w6ebtMSWWW
         MthhvCQeA30ZIpRq8iKF2WF2ljjzsMuFrFhrG6lbJBX0jqVIo/k+vD82j8BzelD9A6
         ol6LTIaaa6voLgKPoPDYbXfx2rbQVNpowkwKSvoaQBTMUSEFeGFU1L8AuIhBtGrrXV
         RjJiYNNnf1BlNxxKoI3xsu0BgMCC7xCVNCfZlYEsfXiG6JywfqKSDL5HiC6ENeRHbL
         zFjKYX23UynQKk/BSeXp7np9c4J+f3grJvQMmXjOm0CB1/Dj01Z6wD9BPAkOSi5FVu
         10lJp1anZ4xjw==
Received: by mail-wm1-f71.google.com with SMTP id v190-20020a1cacc7000000b003456d598510so3062732wme.6
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 07:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ekcv8bNIXIYPhjro0Nb278CmOGUMMLIkTcaAs3AM2AE=;
        b=eCNdsGOaEX+pB+GEdugtfJwrep22SBD/R9fAAWOmrkTBeG0UIIhtN6a8FdwmEqLTlg
         dTSCYOXTpfmE8TKz2FB9pe+1onYyUdWUl097dn16PH/BvFF5aXlJGFwDkwiXQJbeCAN7
         Lh00Y/H1VmfTqkXXEhmBKCE0hJGEWsd0EOW3KXM6ZJpcu1OvlHPVdXJzMoldkYYwOrZZ
         wPKbS3oQTcx7wB8Acxb7QaJjyYNVAv+Kd+efKz0elVAI8MbAZuNauXCnY1su4uhR6Gmb
         ZpJMpgURLSKDUIko50Mx61KnNxRFru1ROTdQZs/Bi2lF5OOcQuQ3RH+Ebl8Fn98DSwoc
         MN5g==
X-Gm-Message-State: AOAM530xZDaQSW5AA1ILgnPAMDS4BzdSG5mPJ6wyf5ppjJBJUGq9jyiF
        d7wCer31lf5koaAChPQKvQU+W8hwzgnLvtTmJuuHQXC1mVROU3JjDV2Rc3OkfPuM15ZbA/7KvYT
        wDOzOBn4Lq3FhvQ+MYoz6dxoFhf0OECsVYrMLFA==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr3004629ljp.188.1639753756767;
        Fri, 17 Dec 2021 07:09:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHJzYnX2gs6VoqK9iRkmiSREooJ2FXXIbMDOX3XDHzAr4mBWfowLrbkwZGknR7FEjLbWDk2Q==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr3004581ljp.188.1639753756369;
        Fri, 17 Dec 2021 07:09:16 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d4sm1429654lfg.82.2021.12.17.07.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:09:15 -0800 (PST)
Message-ID: <61ae4cfd-a544-96d3-d521-877b8b38b5fc@canonical.com>
Date:   Fri, 17 Dec 2021 16:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 17/17] MAINTAINERS: update riscv/microchip entry
Content-Language: en-US
To:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atish.patra@wdc.com
References: <20211217093325.30612-1-conor.dooley@microchip.com>
 <20211217093325.30612-18-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217093325.30612-18-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Update the RISC-V/Microchip entry by adding the microchip dts
> directory and myself as maintainer
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2345ce8521..3b1d6be7bd56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16348,8 +16348,10 @@ K:	riscv
>  
>  RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
>  M:	Lewis Hanly <lewis.hanly@microchip.com>
> +M:	Conor Dooley <conor.dooley@microchip.com>
>  L:	linux-riscv@lists.infradead.org
>  S:	Supported
> +F:	arch/riscv/boot/dts/microchip/
>  F:	drivers/mailbox/mailbox-mpfs.c
>  F:	drivers/soc/microchip/
>  F:	include/soc/microchip/mpfs.h
> 

Good to have the DTS covered, so FWIW:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

You still should get Lewis' ack (unless he merges it)

Best regards,
Krzysztof
