Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701526429D8
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Dec 2022 14:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiLENu2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Dec 2022 08:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLENu0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Dec 2022 08:50:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5E13D04
        for <linux-pwm@vger.kernel.org>; Mon,  5 Dec 2022 05:50:20 -0800 (PST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BF973F32A
        for <linux-pwm@vger.kernel.org>; Mon,  5 Dec 2022 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670248216;
        bh=lDFKXKvJN0XrlcubPN8uKD86PQNw4+8sbbVe0b01rSk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=DILNgyuuQRvaC8t9x9TLhrnGXXjAkckN7H1xGpyNotp6aw65VCC0kNYaHjnLohYId
         PiO2fKrTpNEk6EVLl7Asy0HmUw4019IyNJxujQFObIPw1n04RhtM7V5cZwzja6rPfU
         MxHfYZX0YJljh4+cn6CBQOWcgeXSGn6DnIBBonMDGlzIyT3X9Kg98V/3E9Nu5SASZm
         eFD0wych0LxQf4DpxrD7teTOPE1liz50zPPu6d2wsUyCyMt/sXVxBy/EPpjYLatig6
         emRbWxvAivoMSM7IRubvC3RuqCEB4666EdhHU8VqKgFsV/t9DNxcE1w4flIqrzkjvv
         +XZi6GnaxMHvg==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-39afd53dcdbso121157277b3.8
        for <linux-pwm@vger.kernel.org>; Mon, 05 Dec 2022 05:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDFKXKvJN0XrlcubPN8uKD86PQNw4+8sbbVe0b01rSk=;
        b=rQpm3Ml0RGteJ584aFVKR4XfiXJdMi8lcFAUy7MbpCGzEEAqzyIdcjnlcJoZ5HmpIN
         2yaMxuoq2nNryL8Tib/L+nmmKrc7p/FZePVrt9z5P8JGe7LhGRPOeKZBOieJmQzfHa8a
         DGYA1xKfRP/9bKERjseFww6HdxfzPVdFRpcKmYOToXIZ+1rNNxspZTpOCio5rdq1IPvx
         WLcuMXph7ZKRv7OKulFDx/TeUg/f4l5Tj9MnBHb4wOkD0CY3QN1RE9w8nDdqqlq5Ioiu
         uN8maAlqPJyg61ZO0vaKtfsfjohx1Ws11NM6M1I2rdGBKcL4bdwt9byapgQg+4iX0B8W
         GXaw==
X-Gm-Message-State: ANoB5pm9PNU35LRi80NvSuG27M7b5Y9yYhiNJpHJujNsXT+7cmx2kFVD
        Y7aRsCXLxP+/6tc1b4atxQzhfDY8jTmrZWXfK26ygtBNIjBD6dCl92jHjSWPJFmeoBCDR5SGii1
        OY04EpgvtnFH3Bj0tz0+JBBuap+XMyd7oxb8mmV6SzhM22jKAhcfLDw==
X-Received: by 2002:a25:3f85:0:b0:6f4:61ff:6624 with SMTP id m127-20020a253f85000000b006f461ff6624mr41754933yba.551.1670248215359;
        Mon, 05 Dec 2022 05:50:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uZUQRlKpVtuE0cNmf6AqSIUjpeENW9bCW8inMdZpCAxHmA3XNmIDthwa0clmQpWAhhZ5bpkGSUQtylakwnSU=
X-Received: by 2002:a25:3f85:0:b0:6f4:61ff:6624 with SMTP id
 m127-20020a253f85000000b006f461ff6624mr41754914yba.551.1670248215182; Mon, 05
 Dec 2022 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
 <20221109120102.ylnseq2w33rvt7fz@pengutronix.de> <CAJM55Z-EVXB6FTWwh_vY_B3LoVv+b7TCQCE7asB8G8wkEwui_g@mail.gmail.com>
 <20221109153311.cszr7fgfmyelwra3@pengutronix.de> <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
 <20221128082441.wsqcpuxqk6cynako@pengutronix.de>
In-Reply-To: <20221128082441.wsqcpuxqk6cynako@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 5 Dec 2022 14:49:58 +0100
Message-ID: <CAJM55Z8eGCL9LyPBzgV3JW+qEZAoMLn3v7nkwwoMVGTjEg6vjA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state succeed
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 28 Nov 2022 at 09:24, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Wed, Nov 16, 2022 at 06:41:06PM +0100, Emil Renner Berthing wrote:
> > On Wed, 9 Nov 2022 at 16:33, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, Nov 09, 2022 at 01:45:43PM +0100, Emil Renner Berthing wrote:
> > > > How about we merge this bug fix that can easily be backported first
> > > > and then look at how it should be handled properly?
> > >
> > > I thought it wouldn't be that hard to do it right from the start,
> > > but I admit it's harder than I expected to get right. My prototype lo=
oks
> > > as follows:
> >
> > This works for me (modulo the two extra {'s). I'd still prefer merging
>
> Yeah, didn't even try to compile it.
>
> > the simpler version and then this on top for ease of backporting, but
> > as long as the race is fixed I'm fine. Will you send a cleaned up
> > version of this?
>
> I'd let Thierry decide what he want here. Depending on his choice I can
> clean up my suggestion (inclusive compile test) on the then relevant
> state of the driver.

@Thierry, it seems this is stuck on some opinion from you.

/Emil
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
