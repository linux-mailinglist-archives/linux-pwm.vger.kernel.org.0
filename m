Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFC85B0C
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 08:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfHHGtb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 8 Aug 2019 02:49:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40202 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfHHGta (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 02:49:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so57219239oth.7;
        Wed, 07 Aug 2019 23:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vofpqJmWPCpdTKORwInySY406kDvTjoQzZVxHXBRsCA=;
        b=UF11r4q9UKVUWkdNTE+q8j+ikNTKplXH2s+Irx7sDBkEL7XKD9146FwIL9jjrfozQT
         zjbAauyLSgV/9ZwPYp7zbK1veiE3rlEQGG2IcYRfPpFKbZBGdqFn3iQpipsS1q7rvVca
         PNuMauiceiQmJkwKcLuTbW1Xdw3BGNzqS7bOEK3626qGq1vxYruyTn/ZEj+o7jweGEzw
         Es6WNM4kyXoFzokFJT9ztLi91U7hYIPEdNCInwZo0cKbqf0EdsS9GstqGjQ5DpG2K/4Q
         htSkC8VydQVd10DT0DLQQ5eOUmiyEHOefbfMpYQHxF9JpGON1nd4VKR+GwJGAL85DLmZ
         CN5A==
X-Gm-Message-State: APjAAAU7kYYQ8DPTK/mZt3y/eh4X21mSID+8vLEoDK2GQnsjpcw45tt/
        SOhWYgmetfX+jY4bAWrSZvuKbxz1zSVqgeJ4QDya3guF
X-Google-Smtp-Source: APXvYqycaCgOY64ZbYNjNBxSzXJK4/qbMAr5CyoE77wU6UV+kSw0FkDIeGR/ERUBuvE0QEGUiPJnTOr2vaaBVBZgTyE=
X-Received: by 2002:a9d:529:: with SMTP id 38mr11812023otw.145.1565246969609;
 Wed, 07 Aug 2019 23:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de> <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 08:49:17 +0200
Message-ID: <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Thu, Aug 8, 2019 at 5:53 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Uwe Kleine-König, Sent: Wednesday, August 7, 2019 4:03 PM
> > While at it: If there is a publicly available reference manual adding a line:
> >
> >       Reference Manual: https://...
> >
> > would be great, too.
>
> Unfortunately, the document is not public...

RZ/G1 has the same hardware block, right?
Its Hardware User's Manual is publicly available, e.g. for RZ/G1M:
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg1m.html#documents

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
