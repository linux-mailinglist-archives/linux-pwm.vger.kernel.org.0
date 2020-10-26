Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E442990E5
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783705AbgJZPTv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 11:19:51 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33082 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783347AbgJZPTv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 11:19:51 -0400
Received: by mail-ej1-f66.google.com with SMTP id c15so14178640ejs.0;
        Mon, 26 Oct 2020 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVCULFh/HSUomtNcBIFR0JMZ7sMmUjhTNpFI+1qIyFQ=;
        b=srN5VM0TT2gcHKYehOQsyh/wiLk/7rh6a6UAwl5rYNz8T8i8iTsJSMH8RqWN8nWfFA
         pHMbR459cGMtc5NXZRW4v62BZl7zEr8a1x8fJOpUZS1akonSzaHuXxjxn9+kYIg4wu7h
         hABUGo3EjYYCNCdVvjjrtRFxua3vuxnYC2D0Q6rwXOEkR6+6+uBpqaZJuKFBcTpXjGdR
         nQn+tFA4C1+lmsO8UhVWrPzoNwAGqSBQj3fQJHkKR1sNKowYbASKv9RI85Zqx5lHj0jk
         yJGS5B9PEXAIRWef5cU8dsX6DSzmrknvAsD0AnS12r6tJKAzGfv4RCtoogDG0lZWMLLX
         kQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVCULFh/HSUomtNcBIFR0JMZ7sMmUjhTNpFI+1qIyFQ=;
        b=IA7tiKShsQ0wFQ6P4P3KsHfoPQzKvRr9+wAXXczrWFOwXtgYlyj9DZ6bWRpbgyduC2
         ueMu9dePt23aMTFKD1TIkSAzKQU0bmWT4XTg9HJ5K7miHmRgsikTSJSOIBocLUoOSoaT
         cxx97KF8e4PmTgi/rYOrxSLLf0HsnChFdImgMgU3CYpKI/YXVWkdUDAApWQzU+/ZclZK
         qNnOHXQDAi5xPy9xWL6sUFhEN9TrnPyfKBkQaUB6MEtt35RqyMgLU89DrngjLX/VkGg3
         KObiwnmndCgQ2Wzsj0e0etoNbnwVHafMsenz+NW6cbHYsGrfVjrJfDfE4ZkjEk3WCbtV
         dymw==
X-Gm-Message-State: AOAM530btNtGLRb3B8uXCThCaUcxXD5doUSXCAd6pj0YFk+dAYcTISbY
        Y5r2jO5HnOITFbgWI7Kr+bOKA3shxSKOkhrPx4Y=
X-Google-Smtp-Source: ABdhPJxz32SJlXbJzg1AvE3KciOuVRJCIGRb970HxJSINrxzNG5+n4Glj6b28kxu4+056TYmISLJNAvPhkH16cUVLTg=
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr16878992ejr.217.1603725587392;
 Mon, 26 Oct 2020 08:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
 <20201017052057.2698588-3-bjorn.andersson@linaro.org> <CADQ2G_Exk7+uXMcoyFu-VOcSf48Qjvg9KUCm0P6yXdQn8K_3wQ@mail.gmail.com>
 <20201026082732.GB8884@duo.ucw.cz> <CADQ2G_FeBFVa+ep5N8QGMLWrMKEwQf6J2Gu0FmQYf+n942hGew@mail.gmail.com>
 <20201026151105.GB10480@duo.ucw.cz>
In-Reply-To: <20201026151105.GB10480@duo.ucw.cz>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 26 Oct 2020 16:19:36 +0100
Message-ID: <CADQ2G_EX700e2OzZ3s14cd_RiChbOU_MwiF+uR7HmSxzfQ4Yuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] leds: Add driver for Qualcomm LPG
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!

> I was trying to use obviously bogus numbers to make you to specify
> which patches you reviewed :-).

Ahhhh now that makes much more sense.

I reviewed patch 2.
Tho from the quick look i dont see anything wrong with the DTS changes either.
