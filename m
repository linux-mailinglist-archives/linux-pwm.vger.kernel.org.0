Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1F77425D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjHHRmp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjHHRmS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 13:42:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711B65BF
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 09:18:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5232d593646so4528272a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 08 Aug 2023 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691511487; x=1692116287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=bKSFIcXdszKozzCTc8cNe/mGFTA/9baqZ4kS1Bmi76VRkrg8cFj1yxeEIW+K/DHDfe
         zx+jvegoiJ6WXP9AKajA5emtPJzRNcZb4XvT3OiQ6Wtuyy4orPFBkqrK3bTLpGF9Eoey
         vHSqVU3xucTc/bYzvUIAIa69YfgNj5RBINH6JcBgOmH2jMd+2UnTWIm1ns+FyCjKQYnM
         665A5Rs4+ZOwKkomvmrpqsyx8XyC7CckgUchx4ovHy9RS7ZpTonitxSYfYE8eZcaOkFZ
         pPTBF3pQ5rob6rparTzJ5GrIbtomSN3mlwsOKvRDTsrfIAFPBe9b4Xs5cEBhBkhFagZW
         6XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511487; x=1692116287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=KsxQK6q8l0ZZZf9rgZVuL3KTew4ZA10hnXSmEdSYbkXiFLwqNXzRB7vTMl5ey3kn00
         CvhPQr4oWwXkjUAWXCRowYNBib61g1w4WYFRm2wBhtI1AYmHMvzpYzxP7XiPaBd1eJ8B
         G8otXclH8ltNbPrpKNBHDIXFCtCxbBGLrDj+SKx2c04FigkFVVlPf1YPVw/K8wCvITda
         Df/3gjo0pYav0PK8HahCPnWbL5+cUwQiCO2qPM2NEtVP/MdOAk4AYiAWMitu+KUF3zfi
         gleVRzBjfrgc0VIba5mWu3eSPvxkZ8cJHoP5MgX3YWiEjCLZLJvNExHsxTw+NadEvTtD
         k1HA==
X-Gm-Message-State: AOJu0YwBaPL/UI69M6P59RUrLnONFr7pn3i6Me+YFqvogc7R48tDI4mE
        Z1ARXLjvawVu2ZBJ3uuOKWWuMAdI3QtFk/xorqMDXdEY
X-Google-Smtp-Source: AGHT+IGI3NvWLARIAIJ806WzFo1Gu4YYpyDDo+Y24Lhf1uUKTQCBoWPTHY8UkO7PvmeembXLpAFOxg==
X-Received: by 2002:a17:906:2081:b0:993:e752:1a70 with SMTP id 1-20020a170906208100b00993e7521a70mr11879972ejq.19.1691472062881;
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090666d200b00992f2befcbcsm6125952ejp.180.2023.08.07.22.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Message-ID: <745d818d-fbfe-da02-b98d-bd7b2c5059ed@tuxon.dev>
Date:   Tue, 8 Aug 2023 08:21:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, maz@kernel.org, srinivas.kandagatla@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <20230807122508.403c1972@kernel.org>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230807122508.403c1972@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 07.08.2023 22:25, Jakub Kicinski wrote:
> On Fri,  4 Aug 2023 08:00:07 +0300 Claudiu Beznea wrote:
>> Update MAINTAINERS entries with a valid email address as the Microchip
>> one is no longer valid.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Thanks for updating the email!
> 
> A bit of a cross-tree change. Is there anyone in particular that you'd
> expect to apply it?

No.

> If nobody speaks up we can pick it up in networking
> and send to Linus on Thu.

That would be good.

Thank you,
Claudiu Beznea
