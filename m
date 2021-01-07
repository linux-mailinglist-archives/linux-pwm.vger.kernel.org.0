Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7004E2ED1F0
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Jan 2021 15:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbhAGOT7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Jan 2021 09:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbhAGOT6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Jan 2021 09:19:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41477C0612F4;
        Thu,  7 Jan 2021 06:18:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r4so5655468wmh.5;
        Thu, 07 Jan 2021 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCVcwtczNXpiMZSI2P/pb/oZl0dOnAadwhHWuj+5kBg=;
        b=vRBJALUi1E3X+CB6lBUvVjfAjFkhd0ussXp/IW2rBauUGeFHQg0zzYxbYmGd1zA7zM
         raKeMmi3knEzk/6n+9opoBDu6cYxK2Q1K3lprVbAlBBKYvEWyDBpejtTxBqkjui3xK1V
         rusUC52/AkuI3+PgYRtXR7UAo8EUn3LXpsb8wIMSn6VrvhwkpGca2HGTCY1uUrU1yNzY
         hGSSNzUpHezCHqX9RT+bzAv6qqHKytBeLilWa943l7lYzZQV49QVAlrMri3nYAsoUMah
         YpMuCzW99gagS14uo/6lH5H8l+vV79UkqMZuYywNgvC0Oufxei8xK6MRRMt3rerEQD7z
         Niig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCVcwtczNXpiMZSI2P/pb/oZl0dOnAadwhHWuj+5kBg=;
        b=sFoAdkgqQtNkrMxn5k/oaOBuroCtQObUY2+Zm+UJZ1QtPSSQuaALbFwA7Aso3jSt6M
         CKq6jckNgbQngq1PgOcwJKPaKS7xcruc8CXBopaL7cqNHtGA16gC7h63N+lRkEPy5W4P
         82Y17jfQygGjvv4uP3gBsqaLzCtG75cpil3wW0WsxWWcr6N0J0VLDBLTKoK/Q5nc2B68
         ZHfUKdnlGwg/wBt6idUy7laiamilI+HfLqCx2uTLNuKJSfUchFtFXXPCcMCViuk3wMia
         Re8FqVIITpgMemfzHUAmRu1AUJq7/dPZQDLFd7+lvU9ioh3DQ9kkOX6JXDNCCteoXgs4
         8jyA==
X-Gm-Message-State: AOAM530srlqLF2qEuvl8KSrboYXvvcS7X5Cq8HtcByk85Drm6JrR2aJh
        D70qw50FGru/5lXWyyJxqmEqrJmEyTWVGTk5S9hEl4Od8KU=
X-Google-Smtp-Source: ABdhPJzUNuFlFybCyERxJiJPPKLQFtOQpbQUdYYKLu8LWFDj4URfV5uyoPcnsOzN39UPbaPdvVk8vJBIFPDffX9G1P0=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr8204495wml.11.1610029118877;
 Thu, 07 Jan 2021 06:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
In-Reply-To: <X/H5CqcRHelg5M4p@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 7 Jan 2021 09:18:27 -0500
Message-ID: <CAGngYiVx-w-9nwTOCzyAwFicwF0Ed_7CYw7mGxDbMYu4TLky3A@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jan 3, 2021 at 12:04 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> I will continue working on this series in the upcoming weeks.
> Feedback on the .get_state issue would be greatly appreciated.

In absence of specifications, I tend to keep things as simple as possible.
