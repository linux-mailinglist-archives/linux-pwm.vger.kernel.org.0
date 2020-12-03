Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B031A2CD50F
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Dec 2020 13:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgLCMCs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 07:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLCMCs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Dec 2020 07:02:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03623C061A4D
        for <linux-pwm@vger.kernel.org>; Thu,  3 Dec 2020 04:02:08 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t205so1857893oib.12
        for <linux-pwm@vger.kernel.org>; Thu, 03 Dec 2020 04:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qBaAYKZF7FP3opw0GgVwIo/crpaYDCrYJXpX61SYQiw=;
        b=tf1CyDFJrqYkcwdy7w+IqQm+bMij6x84cGF7KCWyK0BkIQiCQgdZETQfs5WIkEOB+D
         f6rZGIs4AV5XCnI9Yqni9yR+zotRzhW6NpqumY0WinxItKgVzHICuW9h59bKLghQ/xZi
         HGzSEPFluz02KFwliNqWVUzSoKgBdu4vf46GHW4pd4I8R8crk0DeU0jZZTjCUPQSLPiK
         zqLdIxS7X5jVkqEQ+ISIQ6MT1kV62rg4WtEp1vTbUCnqEWGekaj01hU6dDAMnYe1Lo7x
         IBt3ulfVMhFblMkLRi5elLc3UKBzMqDzZujjKc2QPep2tD4S4bJSBOC5x7a4PmSto/QX
         bpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qBaAYKZF7FP3opw0GgVwIo/crpaYDCrYJXpX61SYQiw=;
        b=CbjfkeTfnZtlg1jAmTi3/2SwIhG6DIGOlqmUIJi7rTxkOAPSa0GJfos1KltXUyIYrZ
         stiQ7CocjjeSX5JaZ/Zr2vEqqyYwxhcWuAUSE2ML1hwgUU97qzJj6W7ps6dSU+RL88hp
         Z/lov9kPyFGwTCb8G+F+GailVUtu4m9o93FcaMGio2jAJP5kX2wK/aKNj8oF/gI1ijgL
         BCTT+OwOYoeMyc26vf+XQK5wPfPPKwOhCRjn7RzCAQHuNrU543a3LIRwMQ15stN7yRgf
         foIsR3ojSzvnytvZojux+/ARjxn4pGwQihIMAt4mboHRp8YKE29VPNI8M/yO8t5o6RKh
         DxFg==
X-Gm-Message-State: AOAM5306zAqrwi//VL/q68MyWfsz03ahn9e9rT/4dz8xk4gtKUDQiueQ
        5dfQofVTRgsmuYTcwUTvzjg2tXzHqQ6NxG5HqA==
X-Google-Smtp-Source: ABdhPJxktgMlbFL2bLHdUssHALmhOpF8kfqOehXsMbqkKHQUNnIo6jBsASkxZ2WedYyar0tbwDTPiO5ixAjtfODR9rc=
X-Received: by 2002:aca:af4a:: with SMTP id y71mr1502265oie.178.1606996927387;
 Thu, 03 Dec 2020 04:02:07 -0800 (PST)
MIME-Version: 1.0
From:   Johannes Pointner <h4nn35.work@gmail.com>
Date:   Thu, 3 Dec 2020 13:00:56 +0100
Message-ID: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
Subject: pwm: imx27: pwm-backlight strange behavior
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I just tested 5.10-rc6 with a imx6dl-board and found an issue
regarding the pwm-backlight.
Using 5.10 at about level 67 I got a new maximum and with level 68
it's restarting at about level 1.
This was working properly for me with kernel 5.4.

I tracked down the commit, which I think is responsible for the new behavior:
commit aef1a3799b5c ("pwm: imx27: Fix rounding behavior")
Reverting this commit fixes it for me.

Has anyone seen a similar behavior? Is something wrong with my
setup/configuration?

My devicetree backlight configuration looks like this:
pwms = <&pwm4 0 5000000>;
brightness-levels = <
0   1   2   3   4   5   6   7
 8   9  10  11  12  13  14  15
16  17  18  19  20  21  22  23
24  25  26  27  28  29  30  31
32  33  34  35  36  37  38  39
40  41  42  43  44  45  46  47
48  49  50  51  52  53  54  55
56  57  58  59  60  61  62  63
64  65  66  67  68  69  70  71
72  73  74  75  76  77  78  79
80  81  82  83  84  85  86  87
88  89  90  91  92  93  94  95
96  97  98  99 100>;

Thanks,
Hannes
