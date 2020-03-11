Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC3180E8F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgCKDfW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 23:35:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44528 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKDfW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 23:35:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id g19so1082232eds.11;
        Tue, 10 Mar 2020 20:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvi0vaLEyBZ9ymxu4FCteKDf9J81rgG3o9jkvUBm+Og=;
        b=mV6P+bC2Mufk1B+JEZaVpGGrUCCFoNvPFrcdgTQB2TOfM4e8iK4LixWCtG/ots9X2T
         /LFjKQZdf1S4d4H/7rjYwT9zwZJQGbwcn5oRdt4rFL2OwxbAzPFjKbQlh8JD2Iq9ty7I
         XsmDS38QyK0F2EFwurxuX6n8onvqiMiUjUh/P5oeLJ9oi3iIqSZfR45LVTV9HHj7vmVp
         NawccGv3YZ6aGb30yNi4g7izxiQvoWTMFVPL5jTzN8ERQDOpQ1Y79QJ7nclcYIQ8Ko/R
         Tk4sghPemSW+CLbCZuBfhKzPPFkko70LNN2/ls79Og8OZuG7zXANXgygbS9WXY2mzZm/
         Zhtw==
X-Gm-Message-State: ANhLgQ2M23USRo9X+X8lgcU+EJfDMfzLoAYT5PK7f8vfYl6wwsoUOOqe
        35teHSQzfV6Obk1ndcrPqjuDETRJw9s=
X-Google-Smtp-Source: ADFU+vv4Mk0fYKK3rISZ/tn2dNG0wostgUsNwzdJmYvVafmaJ5B6n6tm70fl6rWvWo/Q8m3E+4WsLw==
X-Received: by 2002:a17:906:404c:: with SMTP id y12mr582776ejj.153.1583897720015;
        Tue, 10 Mar 2020 20:35:20 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id x6sm397650ejw.19.2020.03.10.20.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 20:35:19 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id 6so730909wre.4;
        Tue, 10 Mar 2020 20:35:19 -0700 (PDT)
X-Received: by 2002:a5d:5509:: with SMTP id b9mr1406950wrv.181.1583897719254;
 Tue, 10 Mar 2020 20:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583889178.git.gurus@codeaurora.org> <d2d973f90eb1bbbcddf5dabaa99659dacf721744.1583889178.git.gurus@codeaurora.org>
In-Reply-To: <d2d973f90eb1bbbcddf5dabaa99659dacf721744.1583889178.git.gurus@codeaurora.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Mar 2020 11:35:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v65udRk8A6-ZBT8MRo9SUmhc-9i7PeVBi0UTtNMTx_QbKw@mail.gmail.com>
Message-ID: <CAGb2v65udRk8A6-ZBT8MRo9SUmhc-9i7PeVBi0UTtNMTx_QbKw@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] pwm: sun4i: Use 64-bit division function
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 11, 2020 at 9:41 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
