Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6181B17A653
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEN0I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 08:26:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37774 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgCEN0I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 08:26:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id a141so5717448wme.2
        for <linux-pwm@vger.kernel.org>; Thu, 05 Mar 2020 05:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=NzJlwBLu2PMXJhvFCCamBP6u57AQ/SuSFKrWPDuWILQ=;
        b=a697x9HiNkVQHItHTfxnttcSwWbaOhPz9ubP9b7NU9x/EP2Y2QUzX3zhaQVac6U4OL
         nteXZTLu5Z+SoZQm73w7R7oMIW9uuBa8Z1p5uqOE+RWUmjk0Px932a3MQMZAacBtTB8p
         AgWpqtFPPbqkbHLv9n9Xxsl4md9xcvfa0sPGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=NzJlwBLu2PMXJhvFCCamBP6u57AQ/SuSFKrWPDuWILQ=;
        b=UHDZrqCzY4sPbzBvR6x9BlbbRonw/08KeuUq5kOA361UNMq66tLs/F0Oq/mwM10k2C
         AamsyQBI3BxShyjztMb0429fohrsun/wygt0dkN7jAW2Mqq6t7CkUxYwdTGD3RzFo8rG
         vC9lLWa/erEPzFkya7Px/QZxgq/XZV6MqebsISkjTLOC/PGCWlLcEw1oSI1h8FP0eydT
         SGTscvLSzCh+MaGWN/e+3NPRbFSFi7vJVIlN3rNRq/JT6nUkG9GeWSOiwtrwRIPe+Fx9
         tvv1b7poYEbHT5yHh/2GbyyLCbKoVxEHqOCs1pSU6Tz4OoOIaK8bVabiLpzeU8MIRUT1
         Q9+w==
X-Gm-Message-State: ANhLgQ0IsyU+6Eq4jeXkH0LnhYXWuf5/RQERJSyeWYVdvvI/MQGzcX8V
        KKtmm925CNRYpwhDodh6CxGlCacx0uTxI1Yg
X-Google-Smtp-Source: ADFU+vu/gQ9srOP39BIyg7ghYVlTbTb3qRklu4tSmUPv6SYBuqzYJ8pXCVAKp9igdxtEx8MyKa6QPQ==
X-Received: by 2002:a1c:a4c4:: with SMTP id n187mr9982366wme.10.1583414764858;
        Thu, 05 Mar 2020 05:26:04 -0800 (PST)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id j20sm9477139wmj.46.2020.03.05.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 05:26:04 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:22:32 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?=" 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Inverted PWM output on iMX6
Message-ID: <20200305132232.1aced378@ub1910>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi folks,

I recently ran into an issue using the pwm-fan driver with an inverted
PWM output on iMX6.

The fan is defined in the device tree as follows:

	fan0: pwm-fan {
		compatible = "pwm-fan";
		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
		...
	}

In pwm_imx27_probe() the support for a third `flags` argument in a pwm
reference is enabled:

	imx->chip.of_xlate = of_pwm_xlate_with_flags;
	imx->chip.of_pwm_n_cells = 3;

However, the flag is ignored and the output is not inverted.

By adding some prints I saw that when of_pwm_xlate_with_flags() is
called, args->args_count is 2 instead of 3.

Looking at the definition of the pwm device itself in imx6qdl.dtsi I
can see that the number of cells in a pwm reference is set to 2 not 3:

	pwm2: pwm@2084000 {
		#pwm-cells = <2>;
		...
	};

That seems to be preventing a third argument from being passed.

I can change `#pwm-cells` to <3> and then everything works for my
device but I'm not sure that is the correct solution for everyone. That
would require all pwm references on iMX6 devices to use 3 cells. The
code in of_pwm_xlate_with_flags() seems to be built to handle either 2
or 3 argument cells but I can't see any way to allow this choice in the
device tree.

If the solution is to set `#pwm-cells` to <3> I'm happy to send a patch
which does this and updates all pwm references in device trees which
include `imx6dql.dtsi`. Before I do that I'd like to know that it's the
correct approach though.

For context I've confirmed this is the case in Linux 5.4 and that the
relevant files haven't changed between that release and 5.6.0-rc4.

Thanks,

-- 
Paul Barker
Konsulko Group
