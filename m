Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C564036C1BF
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Apr 2021 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhD0Jc7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Apr 2021 05:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhD0Jc7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 27 Apr 2021 05:32:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC9C61176;
        Tue, 27 Apr 2021 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619515935;
        bh=Rbgd9ScvUHvVNgBxoJ/euzCu2miLQ8d0BwdzOdMWw6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sW0mGt+3GRdyqud1tHJRxYyaMv5pikyhb4v7forC4LGiQ1P83v8XR88ElKxtaNtk7
         34TSWayASDKBiitd+3v+u/npRqb6xzfOIkKOSuCb4g8/st58TmqoQy5qcxVOvIbWKu
         sFZPd5XcQrj1J1qZvXPebp2fCFuq5awYbVMVUzdU=
Date:   Tue, 27 Apr 2021 11:31:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, ac100@lists.launchpad.net,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Allen Pais <apais@linux.microsoft.com>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andres Klode <jak@jak-linux.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        Comedi <comedi@comedi.org>, "David A. Schleef" <ds@schleef.org>,
        dri-devel@lists.freedesktop.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Herman.Bruyninckx@mech.kuleuven.ac.be,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Ilya Petrov <ilya.muromec@gmail.com>,
        Jacob Feder <jacobsfeder@gmail.com>,
        Jerry chuang <wlanfae@realtek.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "J.P. Mellor" <jpmellor@rose-hulman.edu>,
        karthik alapati <mail@karthek.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <ac100@lists.lauchpad.net>,
        Klaas.Gadeyne@mech.kuleuven.ac.be,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, Marc Dietrich <marvin24@gmx.de>,
        Marco Cesati <marcocesati@gmail.com>,
        Martijn Coenen <maco@android.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Michael Straube <straube.linux@gmail.com>,
        Mori Hess <fmhess@users.sourceforge.net>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@protonmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre-Hugues Husson <phhusson@free.fr>,
        Robert Love <rlove@google.com>,
        Romain Perier <romain.perier@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        "Spencer E. Olson" <olsonse@umich.edu>, Stanley@bb.sd3,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@android.com>,
        Truxton Fulton <trux@truxton.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wim.Meeussen@mech.kuleuven.ac.be,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Subject: Re: [PATCH 00/57] Rid W=1 warnings from Staging
Message-ID: <YIfZ4Ad6FxVDtqt/@kroah.com>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 14, 2021 at 07:10:32PM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (57):

44 of these applied to my tree, I'll keep them in my "testing" branch
for now until -rc1 comes out.  Feel free to rebase your series on that
and fix up the remaining ones and resend.

Note, the comedi drivers have moved to drivers/comedi/ so those patches
need to be sent as a different series, if you still want to make those
changes based on the review comments.

thanks,

greg k-h
