Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830B11666F0
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2020 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgBTTOS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Feb 2020 14:14:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTOS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Feb 2020 14:14:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id p23so35013187edr.5;
        Thu, 20 Feb 2020 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWqXaN44z/yeMTbEYKAeUsbnGFMAeS4P+Yea1Fx2AXw=;
        b=CZxktInhRG2R++CeV0l4ZhHrlUOCh5fOSZVOwJHFZMY3onvVwtrB9kHnjvY4U5K9M5
         CWE8rkMfVJFyrb9vvdHB176aOljRwszfZCWSaLkLHl8XRQ68Zt6iQMILPSiTpg18z9UQ
         Lyr2f1ImqXPri3NvINcJNEPtIKr/DHL7jdkYRtpfWDCFnAKcNEBFka26aopqrzqKOMNL
         ff/krK/WcDnkYPxAXWTp9U/TIXBU/r+ogHtZZhC12Yigs7TQ0N0UUBnh1PB1LJfunUHC
         QuWg3hRSDqpXoOuD7+/bgesxVUQNNkRTl/TiDwkiLpxpAYUGlOT7TydPapcDQAAJHDpN
         +aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sWqXaN44z/yeMTbEYKAeUsbnGFMAeS4P+Yea1Fx2AXw=;
        b=R++5alThSG57RPdnmfC8nw7473dtGdRbe3DEOsYVmKTQxZeBaxzIBGS3eHNMiVe9/6
         SqinqY7Vze3qVfAeIv3kuFsDCjciAXvyfsQeIjWlze8B4uDw/BuIahfShdCu+qPB7v/I
         Lht6P8w6m7h2RU7mxpn53RVoyQJkteShF+igPgdLTNSfGdKPct4rdcatVpe0fsWLLugn
         ZyzcLWSiJX74khslSyU0dio2bdrvsNZ+2BGUDId1JajxCYg/pg3W+IfaVqmtc77+y2+K
         99I0zn6zEaiQxOfo5iv8mmRuIbK38ItfICMFqcpA5Tm9rnqL5sgztahqNxlXyaFYXcVH
         6jOA==
X-Gm-Message-State: APjAAAUV1Y5hTCJPlNae9Qzn6GKqLqzROCjgftTZCdgX2AikQfkFRNIJ
        +blL66YxiLLMxTUrfUxKj3Q=
X-Google-Smtp-Source: APXvYqwIg8G2EeOlDDMfRvU5dS3QwrQVLU7wrHG97NbQ2Uya9hf3r0wJ8jiMzwswYui949yOadllSw==
X-Received: by 2002:aa7:d1d1:: with SMTP id g17mr31594014edp.185.1582226056521;
        Thu, 20 Feb 2020 11:14:16 -0800 (PST)
Received: from [10.67.49.41] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t1sm30805ejg.32.2020.02.20.11.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 11:14:15 -0800 (PST)
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        Bart Tanghe <bart.tanghe@thomasmore.be>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Ray Jui <rjui@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
 <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOwU0EVxvH8AEQAOqv6agYuT4x3DgFIJNv9i0e
 S443rCudGwmg+CbjXGA4RUe1bNdPHYgbbIaN8PFkXfb4jqg64SyU66FXJJJO+DmPK/t7dRNA
 3eMB1h0GbAHlLzsAzD0DKk1ARbjIusnc02aRQNsAUfceqH5fAMfs2hgXBa0ZUJ4bLly5zNbr
 r0t/fqZsyI2rGQT9h1D5OYn4oF3KXpSpo+orJD93PEDeseho1EpmMfsVH7PxjVUlNVzmZ+tc
 IDw24CDSXf0xxnaojoicQi7kzKpUrJodfhNXUnX2JAm/d0f9GR7zClpQMezJ2hYAX7BvBajb
 Wbtzwi34s8lWGI121VjtQNt64mSqsK0iQAE6OYk0uuQbmMaxbBTT63+04rTPBO+gRAWZNDmQ
 b2cTLjrOmdaiPGClSlKx1RhatzW7j1gnUbpfUl91Xzrp6/Rr9BgAZydBE/iu57KWsdMaqu84
 JzO9UBGomh9eyBWBkrBt+Fe1qN78kM7JO6i3/QI56NA4SflV+N4PPgI8TjDVaxgrfUTV0gVa
 cr9gDE5VgnSeSiOleChM1jOByZu0JTShOkT6AcSVW0kCz3fUrd4e5sS3J3uJezSvXjYDZ53k
 +0GS/Hy//7PSvDbNVretLkDWL24Sgxu/v8i3JiYIxe+F5Br8QpkwNa1tm7FK4jOd95xvYADl
 BUI1EZMCPI7zABEBAAHCwagEGBECAAkFAlcbx/ACGwICKQkQYVeZFbVjdg7BXSAEGQECAAYF
 Alcbx/AACgkQh9CWnEQHBwSJBw//Z5n6IO19mVzMy/ZLU/vu8flv0Aa0kwk5qvDyvuvfiDTd
 WQzq2PLs+obX0y1ffntluhvP+8yLzg7h5O6/skOfOV26ZYD9FeV3PIgR3QYF26p2Ocwa3B/k
 P6ENkk2pRL2hh6jaA1Bsi0P34iqC2UzzLq+exctXPa07ioknTIJ09BT31lQ36Udg7NIKalnj
 5UbkRjqApZ+Rp0RAP9jFtq1n/gjvZGyEfuuo/G+EVCaiCt3Vp/cWxDYf2qsX6JxkwmUNswuL
 C3duQ0AOMNYrT6Pn+Vf0kMboZ5UJEzgnSe2/5m8v6TUc9ZbC5I517niyC4+4DY8E2m2V2LS9
 es9uKpA0yNcd4PfEf8bp29/30MEfBWOf80b1yaubrP5y7yLzplcGRZMF3PgBfi0iGo6kM/V2
 13iD/wQ45QTV0WTXaHVbklOdRDXDHIpT69hFJ6hAKnnM7AhqZ70Qi31UHkma9i/TeLLzYYXz
 zhLHGIYaR04dFT8sSKTwTSqvm8rmDzMpN54/NeDSoSJitDuIE8givW/oGQFb0HGAF70qLgp0
 2XiUazRyRU4E4LuhNHGsUxoHOc80B3l+u3jM6xqJht2ZyMZndbAG4LyVA2g9hq2JbpX8BlsF
 skzW1kbzIoIVXT5EhelxYEGqLFsZFdDhCy8tjePOWK069lKuuFSssaZ3C4edHtkZ8gCfWWtA
 8dMsqeOIg9Trx7ZBCDOZGNAAnjYQmSb2eYOAti3PX3Ex7vI8ZhJCzsNNBEjPuBIQEAC/6NPW
 6EfQ91ZNU7e/oKWK91kOoYGFTjfdOatp3RKANidHUMSTUcN7J2mxww80AQHKjr3Yu2InXwVX
 SotMMR4UrkQX7jqabqXV5G+88bj0Lkr3gi6qmVkUPgnNkIBe0gaoM523ujYKLreal2OQ3GoJ
 PS6hTRoSUM1BhwLCLIWqdX9AdT6FMlDXhCJ1ffA/F3f3nTN5oTvZ0aVF0SvQb7eIhGVFxrlb
 WS0+dpyulr9hGdU4kzoqmZX9T/r8WCwcfXipmmz3Zt8o2pYWPMq9Utby9IEgPwultaP06MHY
 nhda1jfzGB5ZKco/XEaXNvNYADtAD91dRtNGMwRHWMotIGiWwhEJ6vFc9bw1xcR88oYBs+7p
 gbFSpmMGYAPA66wdDKGj9+cLhkd0SXGht9AJyaRA5AWB85yNmqcXXLkzzh2chIpSEawRsw8B
 rQIZXc5QaAcBN2dzGN9UzqQArtWaTTjMrGesYhN+aVpMHNCmJuISQORhX5lkjeg54oplt6Zn
 QyIsOCH3MfG95ha0TgWwyFtdxOdY/UY2zv5wGivZ3WeS0TtQf/BcGre2y85rAohFziWOzTaS
 BKZKDaBFHwnGcJi61Pnjkz82hena8OmsnsBIucsz4N0wE+hVd6AbDYN8ZcFNIDyt7+oGD1+c
 PfqLz2df6qjXzq27BBUboklbGUObNwADBQ//V45Z51Q4fRl/6/+oY5q+FPbRLDPlUF2lV6mb
 hymkpqIzi1Aj/2FUKOyImGjbLAkuBQj3uMqy+BSSXyQLG3sg8pDDe8AJwXDpG2fQTyTzQm6l
 OnaMCzosvALk2EOPJryMkOCI52+hk67cSFA0HjgTbkAv4Mssd52y/5VZR28a+LW+mJIZDurI
 Y14UIe50G99xYxjuD1lNdTa/Yv6qFfEAqNdjEBKNuOEUQOlTLndOsvxOOPa1mRUk8Bqm9BUt
 LHk3GDb8bfDwdos1/h2QPEi+eI+O/bm8YX7qE7uZ13bRWBY+S4+cd+Cyj8ezKYAJo9B+0g4a
 RVhdhc3AtW44lvZo1h2iml9twMLfewKkGV3oG35CcF9mOd7n6vDad3teeNpYd/5qYhkopQrG
 k2oRBqxyvpSLrJepsyaIpfrt5NNaH7yTCtGXcxlGf2jzGdei6H4xQPjDcVq2Ra5GJohnb/ix
 uOc0pWciL80ohtpSspLlWoPiIowiKJu/D/Y0bQdatUOZcGadkywCZc/dg5hcAYNYchc8AwA4
 2dp6w8SlIsm1yIGafWlNnfvqbRBglSTnxFuKqVggiz2zk+1wa/oP+B96lm7N4/3Aw6uy7lWC
 HvsHIcv4lxCWkFXkwsuWqzEKK6kxVpRDoEQPDj+Oy/ZJ5fYuMbkdHrlegwoQ64LrqdmiVVPC
 TwQYEQIADwIbDAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2Do+FAJ956xSz2XpDHql+Wg/2qv3b
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
Date:   Thu, 20 Feb 2020 11:14:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/4/20 1:17 AM, Nicolas Saenz Julienne wrote:
> On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
>> The newer 2711 and 7211 chips have two PWM controllers and failure to
>> dynamically allocate the PWM base would prevent the second PWM
>> controller instance being probed for succeeding with an -EEXIST error
>> from alloc_pwms().
>>
>> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thierry, is there any chance we can get this applied for an upcoming
5.6-rcX? Thank you!
-- 
Florian
