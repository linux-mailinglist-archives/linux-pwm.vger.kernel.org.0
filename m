Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5843E77956
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfG0Oyr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sat, 27 Jul 2019 10:54:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42513 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfG0Oyr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2019 10:54:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so55674672eds.9;
        Sat, 27 Jul 2019 07:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbC/42M5pQNTgrVBuOqW03/stnb0sjIXK4Z9mFvmX3A=;
        b=RIa/n4tnS+k0bUsd9V0Mer+nEASCjRvuBTRrBiTzpe3sa+584Eoq5XpG4lIX9LafZw
         IS1Vt7yBf8N+OOasjDnJOWsmnKypFi1ymbNS4NTGptXdTSbp8FSbVOxvlDngab+SVnq6
         R/xx82f8qujLz0H6YjodSbIoiheEJQk741UWMz2H3i23vfS7+mJZvqJxMD0SJHFb/+FP
         ySfpEfIdfzENeae3dPqIuu5uyn1gveEdDHVZapvMleHLpTw0VxYezT7TXyNwKA1hi1U1
         +mRcgIg4817OBFtSpDZThW/t88GkhgAJzxe/WufVX7Mq8dsVHDQ6W8PmWrGgZVqJSGXs
         TY7g==
X-Gm-Message-State: APjAAAXxaFsPZdnsr+I7V4wJjEVgKx5QcX7ru1hRctGbyatMy4x/PHIS
        3oWyr48hRvfbxl1P+W+a0egXw1CWlmg=
X-Google-Smtp-Source: APXvYqzPxueSo0tS5nsoPY8gjziQrMRw5Eo68k/J6/nzzWbMpQWvPLTgKLJJ/eQNQHtEt5hPuts09A==
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr90575170eds.55.1564239285065;
        Sat, 27 Jul 2019 07:54:45 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id g22sm6240782eje.84.2019.07.27.07.54.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 07:54:44 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id n9so57382599wru.0;
        Sat, 27 Jul 2019 07:54:44 -0700 (PDT)
X-Received: by 2002:a5d:568e:: with SMTP id f14mr27625205wrv.167.1564239284357;
 Sat, 27 Jul 2019 07:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-6-jernej.skrabec@siol.net> <20190727105008.he35sixfvoyl2lm7@flea.home>
 <4063694.66Ui2fGJfo@jernej-laptop>
In-Reply-To: <4063694.66Ui2fGJfo@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 27 Jul 2019 22:54:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65a9jF3QsEQgTim_XxXjhd9K0KwDRxtqYMqsiy2yWLeBg@mail.gmail.com>
Message-ID: <CAGb2v65a9jF3QsEQgTim_XxXjhd9K0KwDRxtqYMqsiy2yWLeBg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 5/6] pwm: sun4i: Add support to output
 source clock directly
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 27, 2019 at 10:28 PM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne sobota, 27. julij 2019 ob 12:50:08 CEST je Maxime Ripard napisal(a):
> > On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> > > PWM core has an option to bypass whole logic and output unchanged source
> > > clock as PWM output. This is achieved by enabling bypass bit.
> > >
> > > Note that when bypass is enabled, no other setting has any meaning, not
> > > even enable bit.
> > >
> > > This mode of operation is needed to achieve high enough frequency to
> > > serve as clock source for AC200 chip, which is integrated into same
> > > package as H6 SoC.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > It doesn't seem to be available on the A10 (at least) though. The A13
> > seem to have it, so you should probably check that, and make that
> > conditional to the compatible if not available on all of them.
>
> Ok, can you suggest the name for the quirk? "has_bypass" is suspiciously
> similar to "has_prescaler_bypass".

has_direct_mod_clk_output?

> Also, how to name these sun4i_pwm_data structures? Now that there are (will
> be) three new quirks, name of the structure would be just too long, like
> "sun50i_pwm_dual_prescaler_bypass_clk_rst_bypass".

Just use the SoC model. Any later ones that have the same quirks will likely
use the same compatible string anyway.

ChenYu
