Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAE39DE06
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGNtw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFGNtw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 09:49:52 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D560FC061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 06:47:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t40so5073798oiw.8
        for <linux-pwm@vger.kernel.org>; Mon, 07 Jun 2021 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cLyMY5g03ahok1tn4t4Pa6mMMga/L4ZfJLjCLj7pDP0=;
        b=uTBHRsXAU4cHKwUvxHqShX6JsUOSMqFGxAFziV2VkE2DcX1YdDkQHb/b69qL0MvrbO
         hxPzlkQPkregQBnlPek8h5SHdGY5gJz4FXE0YpGtNrYE/EYeRaBSliDHPN2uGEPjxyi5
         xjJ+94520VI0jID/gJm07r4RJzHtT5Fbbv/p9Sl4B/EmXRPlovpRKN0ZNUXkr+a3b/vP
         s2Riz2uK8xQJd4yy2J92tKhY4ynQxxCduyixMrABjGjfSqvolvt3tWxqQLK/kJC03ZqH
         RNugZxUAEUWfJWdyJGzmYTmt8lQtX7qjHLcaL8jybbz0xTktynutqIotAZ4Rl56D1IbR
         KdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cLyMY5g03ahok1tn4t4Pa6mMMga/L4ZfJLjCLj7pDP0=;
        b=JKrJqnnDcKaN/bkm4IMll9r/0Hh8Wsgw2+UZr7gq2yJ11/w7uA15TTPhhGMlcFO4N7
         JZhc8iBv6eaoFZyB+5vqt+5mgdM7cnEXcWV9vvDnvICriLWkmCU0k5zomcOpFZPNvfSi
         2CcrQEOSEurtHrv69u1+5w+MtDeTGBzXRQPq/PeVhvcli2etCjS/JkandSJy4uC54J4F
         fCkqIQkhAPhjRcRfvxk2SJ/WA2s3BOSLi4imOJEk+uz/wTcOsNr+yjma+ixL3DghbNFi
         Tavk+XYGGhzLayYCQg20HHEPiKMQl0Dm50dZlf08ltncXMrvaydsjvN+5WvjudpVhJ/z
         rlSQ==
X-Gm-Message-State: AOAM5331gj92uCNYRUWmIWiCBfaRy3/7Lih5E1MC3qI+0gb+wD6d/HcY
        WZbzRuxmIvJpFaEC2GYkH4xEo04AcPuh+eBK98MsYhipp8I=
X-Google-Smtp-Source: ABdhPJwn5aOQek50B3fo6aTgQKNgkpubv9PMP+L9WoU378BU/C4utUgCNX1Bki3mKJIPU9ITjau1RJyv+zpLE4CpL7U=
X-Received: by 2002:aca:6207:: with SMTP id w7mr19523653oib.177.1623073667235;
 Mon, 07 Jun 2021 06:47:47 -0700 (PDT)
MIME-Version: 1.0
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 7 Jun 2021 15:47:36 +0200
Message-ID: <CAO1O6seyi+1amAY5YLz0K1dkNd7ewAvot4K1eZMpAAQquz0-9g@mail.gmail.com>
Subject: Atomic update of period and duty_cycle in sysfs
To:     linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi everyone,

I don't know if this has been proposed before, but I propose a
period_and_duty_cycle attribute in sysfs, beyond period and
duty_cycle, that could be used if both period and duty cycle should be
updated at the same time.

When we programmatically want to update these values, it can currently
be a bit tricky to get this correct, since if we write the two
attributes in the "wrong" order we could end up in a situation where a
write gets EINVAL as result, depending on the current values, since it
must always be the case that duty_cycle <= period. We also have the
issue that writing one file at the time doesn't result in an atomic
update, so potentially the user can observe a strange behaviour from
the pwm between the two writes, because for example the old period is
used but the new duty_cycle is used for a short amount of time.

A period_and_duty_cycle attribute would fix this, where the two values
are space-separated.

/Emil
