Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869C7CE07C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2019 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfJGLat (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Oct 2019 07:30:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40417 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGLat (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Oct 2019 07:30:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so10619096ota.7;
        Mon, 07 Oct 2019 04:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F0WkJv48+GPGKyb1Dgf9OLKRcqPwFjYveqQlob2kvM=;
        b=CK9ah5jPwKoYfH8whGvfCSbF4JUo0tB5vv6QheUJAVUYf8B2asBSpzKFKD1O3ha2XZ
         5SxwKo4na/ftDS9cT2QbqtOPqzflWr2Rgypd5qt3bsbQLajJKW6qGhX0ZfeQTkipe6Yh
         4JmmZBczek2uVT9Z38JXgNNI2ieVjw7RoZxYtZPvj53Cf1MbyQKfFOzGOV1E+LRO6xdl
         ZDlUOkJZp/M2GpbOi6XX1z+9BMD+dYXr+4bW8CaOPEHZvOwqdtzcz0Cax5bLbb6AOd2t
         Hajv9PGLnzKq8OHsapn8Z7h/bIKzN6w4rnjMaX0ZKmy1jHXXXc8iECgPzWVK4pwffKoe
         1RIg==
X-Gm-Message-State: APjAAAXv2V3dlOY4QqwAU2d4PVjW4cXxxmaQyXJ2eABueTZculzf5gR+
        0uPogyxdZbecunlqA0bJLeI4e68NJBfrl41+lEw=
X-Google-Smtp-Source: APXvYqwnbiaCerhQZkfhR6ihvCrToXIJMFZIzVImomPLDjPNDMH9GS3mk5H/WRI6pkMRCXHijjz82wobtOwBNezlmtY=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr11215187oti.39.1570447847197;
 Mon, 07 Oct 2019 04:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 13:30:36 +0200
Message-ID: <CAMuHMdVrO9+cCd_C_ANRjMNSo2yasrUXzhQUeZmau_c9FT8bCA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774b1 support
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 1, 2019 at 2:03 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
