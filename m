Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43352988FD
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772487AbgJZJCi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 05:02:38 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45751 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772468AbgJZJCi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 05:02:38 -0400
Received: by mail-ej1-f67.google.com with SMTP id dt13so12235599ejb.12;
        Mon, 26 Oct 2020 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzPLDonQyAo9U+lyuctB2TaEgIfVbsLYU560QT60WkI=;
        b=Q8vCXKlGk2QyDILH1Knc0fuOnTp5Lqvftby+PpEsHgz8NQEC5sfNko0PWuq+vHj/YW
         yrCAxFtPSt03R2pdj8docmGVEsKkD+Z4c0lczBSPPBSkE5cM7fado3AgDtwaHNI4hAUc
         61rPHgNXehwyoP29bI0xhoY/sPU4pV8Rlrq9tRzOhN8OEpla95L4t3vya6bMF4NEEEdD
         dHDSFaFiJe6jTFkANPsWGicAOriYtUwfPpDXwX+evI14wsFUdUomVGbjf0gPjgPp735C
         oZu7EV60YEVBQUzzPF3zu+1sfb/Ht9Qew0jH+J/aIxLx6DYpc2Qc8ZO0D57WMxkVBRuu
         vvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzPLDonQyAo9U+lyuctB2TaEgIfVbsLYU560QT60WkI=;
        b=BU8Swd0Pgvujj2BtbRpj2VX/ReuY86BY7TFx5SqE2eY1AlDaeAyo7EhvjIPDZ9WGiN
         kz+h+x+B899K3/jRYaAPyT9+vFeUGehwpkOzQse87sS0hcSmrsSrecZ2/PmXPeQ3CMbe
         uUeUDU7HIrq7qgBGCJ2zyZCiRsGDUK81xyC92dncMXxEZ3VY8ga0sUcQaoJvNe/kBI4I
         zG/BAtCdNEgTvtHrti4Jz/Jr4CLg8rUT8DeAqJd3NXoD1J9oLpLYKBs8z8lCe6jXvcem
         wSthSvh9jmBdJUfDGtcx3IrONOmmdMs7lLRCSUZHCWpVydO2DTlT/kY8MLqUEvcnDgA8
         R5Ew==
X-Gm-Message-State: AOAM530mGr2bJDRmhn8tPrpFzyiC2x5E76GNZjDZg+X82nDNWqnV+H1e
        y979NxmUkR26dZYWLG8KD38XygZ3914KcudRXXs=
X-Google-Smtp-Source: ABdhPJw8MAIw3Y8WUOIEtj9GR44OTgWuMdGEEAMA6kcT6Q/ozil5aLKdvx1SN5RhQo/ttdxZm/awjh50AxhLfRnK1FU=
X-Received: by 2002:a17:906:4b0f:: with SMTP id y15mr14244145eju.198.1603702954582;
 Mon, 26 Oct 2020 02:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
 <20201017052057.2698588-3-bjorn.andersson@linaro.org> <CADQ2G_Exk7+uXMcoyFu-VOcSf48Qjvg9KUCm0P6yXdQn8K_3wQ@mail.gmail.com>
 <20201026082732.GB8884@duo.ucw.cz>
In-Reply-To: <20201026082732.GB8884@duo.ucw.cz>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 26 Oct 2020 10:02:22 +0100
Message-ID: <CADQ2G_FeBFVa+ep5N8QGMLWrMKEwQf6J2Gu0FmQYf+n942hGew@mail.gmail.com>
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

> Good way to say that is "Patches 7 and 28, Reviewed-by:"...

7 and 28 ? I dont see any patches 7 and 28 (I assume thats a typo for 8)

Either way.

Reviewed-by: Martin Botka <martin.botka1@gmail.com>
