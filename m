Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC311D6D1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2019 20:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfLLTHl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Dec 2019 14:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbfLLTHl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Dec 2019 14:07:41 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A983F21556;
        Thu, 12 Dec 2019 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576177660;
        bh=ANPuit8CUGvpyOSxrfqaVoP/O11me6aRM0Z9C3p/CxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cFbL/N62GrrXsrO2zofuHlY4+fwwWdtZJfItGnjsbRY1qjtFMWpj1y9WZtpRF3PDv
         lDqtzDjhimb0EYmft7jiZihhHa0EtEdHBOjsSfrNxwfzM3LN+28Dy6t0dvrLL7HiSN
         MXDvbQl5mPhf46ocXbA5s9hluonthbOTZyIPBtwU=
Received: by mail-qt1-f171.google.com with SMTP id g17so70405qtp.11;
        Thu, 12 Dec 2019 11:07:40 -0800 (PST)
X-Gm-Message-State: APjAAAUqokheDyr01YB6muHHQdyxYq2qLn+n4VBsOgxwxzi52Zo4SJ39
        vNDOpJ12JeOUvumuOempH1yKCoMf5TSUmTOMQg==
X-Google-Smtp-Source: APXvYqxPd7u2BVtzEcJMszwB++LSELwIU5oN4rc6uLt/0iXtkRbuFYfXjWly+Op56BYv8RBb77vw/SpXprWPBF1drRc=
X-Received: by 2002:ac8:1c4e:: with SMTP id j14mr9145655qtk.300.1576177659861;
 Thu, 12 Dec 2019 11:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
 <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com> <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
In-Reply-To: <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Dec 2019 13:07:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
Message-ID: <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 12, 2019 at 2:16 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 12/11/19 8:52 PM, Rob Herring wrote:
> > On Wed, Dec 11, 2019 at 9:00 AM Benjamin Gaignard
> > <benjamin.gaignard@st.com> wrote:
> >> Typical pwm nodes should be named pwm@xxx.
> >> The pattern shouldn't match nodes named pwm-xxx to avoid
> >> conflicts with pinmux or pwm-fan nodes.
> > It only matches pwm-$(a-hex-number), not any string, so that shouldn't
> > be a problem. This is needed for things like GPIO based devices (not
> > just PWMs) which don't have any address.
> >
> > Pinmux nodes are going to need to adopt some sort of standard pattern
> > we can match on.
> I have push a patch to stop using '@' and '_' in pinmux groups names:
> https://lore.kernel.org/patchwork/patch/1162591/
> It remove the warnings when compiling the devicetre with W=12 but pwm.yaml
> complain because pwm pinmux is named pwm-1.
>
> How can I solve these issues at the same time ?

Name the nodes *-pins or *-pins-[0-9]. You're probably going to need
some pattern anyways when you do a pinmux schema.

Rob
