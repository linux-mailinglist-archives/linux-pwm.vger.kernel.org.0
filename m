Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A800A2356C2
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Aug 2020 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHBLyk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Aug 2020 07:54:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50998 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgHBLyg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Aug 2020 07:54:36 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE3C91C0BDA; Sun,  2 Aug 2020 13:54:33 +0200 (CEST)
Date:   Sun, 2 Aug 2020 13:54:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200802115422.GB1090@bug>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729063638.GY1665100@dtor-ws>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!

> > +static DEVICE_ATTR_RW(ps_seq_id);
> > +static DEVICE_ATTR_RW(ps_seq_loop);
> > +static DEVICE_ATTR_RW(gpi_seq_id0);
> > +static DEVICE_ATTR_RW(gpi_seq_id1);
> > +static DEVICE_ATTR_RW(gpi_seq_id2);
> > +static DEVICE_ATTR_WO(patterns);
> 
> Should this be a binary attribute instead of having string parsing in
> the kernel?

Plus... is this suitable userland interface? Should it be documetned?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
