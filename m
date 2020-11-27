Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3C2C65E9
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 13:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgK0Mps (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 07:45:48 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgK0Mpr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Nov 2020 07:45:47 -0500
Received: from [192.168.1.155] ([95.114.158.11]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPp0l-1kWAmh23Dn-00Mw0R; Fri, 27 Nov 2020 13:45:20 +0100
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>, zhang.lyra@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>, orsonzhai@gmail.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-pwm@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Scott Branden <sbranden@broadcom.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>, baolin.wang7@gmail.com,
        Shawn Guo <shawnguo@kernel.org>
References: <20201117154340.18216-1-info@metux.net>
 <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
 <20201118095342.sviuxvfsbmmn22mo@pengutronix.de>
 <CAHp75Vd9QUCcUoPLUW3kkJC0h=mPUqHNqNJPY74gDGSu67t8Hw@mail.gmail.com>
 <CAHp75Vcdu1aOLuF+EFDZibbi0OwGH4QfBhJQm9VZQkeEGEeKDQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <40d468a6-f8ba-7535-55dd-e91ba8299958@metux.net>
Date:   Fri, 27 Nov 2020 13:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcdu1aOLuF+EFDZibbi0OwGH4QfBhJQm9VZQkeEGEeKDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yMIP6nH7cKntCrJuLgf/M3+4XwFIPkg7UfYtSb9J0SkpG6sGOv7
 /IR7PEjcUkbXZfn95xvF9kPZZUOb9RUnvrwEmPu6rP+AgFH9G1KbtEQbrGI6dOjDEAwqV/E
 EczzEgEJ3pvoStGVhjYfBSBY8R6QOUQt5Ao1T/pFBNKAztiWswegrgTUhY7Sz/LsMkjc4PG
 AXU7u5vqunrqkbLcYUoQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5fjPJhCYJQ=:4vrnvGfA8e+95x4fem3OkF
 DfLkWIz4U0aBa8HLZrIOXcD4NWRi5pMo8Oa4rh/JJ6ngXDJTm/+FAY8quNYB/ANwdfDZQe48s
 k2CqQzxtZtilcnmHKe3lkzxpcwcFbAmCgCYFK3D/auj506nTbYO4c624QAzeKlxqJ9aCHd+Wt
 hI3o1ZxJl9DrzDwcoXjkznsF6FbhuSIoOss3ewNaFyBSbu3g2nqwNlNyj2HOFbPxM+r/J2tuu
 bZJU0A6yKpvQn5LrOthHb8IMcDYU+ctkst0nQXTHzlI8rZMMh1Y6r4K/vLbyb1aJ7BZlF8YaF
 Qx59hp3Vk6LqR7JSnkqsESRE70Qu6MnElAe5u2/7HTI9LGVM6UaRVUiDMjxUT4psNxVyefUaX
 /w7EbD7LArRl27YIShkQumClWDiabxBy/5FbFvypZGCtrLVGaftrxq8KTeQFL
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 18.11.20 11:01, Andy Shevchenko wrote:

>>> So a system without CONFIG_OF might still make use of .of_match_table?
>>
>> Yep!
> 
> If you are curious:
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L615

Phuh, this changes everything ... sorry, didn't know that.

If ACPI now can contain OF pieces, we should ask the question whether
of_match_ptr() should be used at all.

Would it be a compromise introducing a new macro (eg. "OF_MATCH_PTR()")
which passes through the pointer if either OF or ACPI is enabled.
Maybe we could introduce a new config item (eg "OF_MATCH_TABLE") for
that, which is enabled by both OF and ACPI. And maybe add an option for
of-compatible checking in ACPI.

How do you folks think about that ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
