Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6340EB14
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhIPTui (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 15:50:38 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44940 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhIPTuh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Sep 2021 15:50:37 -0400
Received: by mail-ot1-f53.google.com with SMTP id y63-20020a9d22c5000000b005453f95356cso2874995ota.11;
        Thu, 16 Sep 2021 12:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KsoWtKkhaXMiBJDC0/XxZwnXXQWFGw8B4mYJMIPHr0=;
        b=SpxCjz1AW/J5PsTvzRCCmPvXqxsy2xGpwFm86c/Vd9vbTwvcR4iNTA4o8ZoXZVqMXO
         XLxJNJ//imPrevRkKbeFs4T4DJDbFeMGJRxVnlCpnJlIjvtHlSy4T+bmF8ZP+XlLUAky
         Drb5qdsWDgZf2P7EcB6PrmhGjm9KJcI+gaqIKgWS79+WfTfJjibFkBD61FawGjUuoRDj
         6aYq8H+Uhc6PsYQnbtYW8DYp+uh3LoMJXnwTZWMfvL1qwpkdLuzMncu+u3CkCfPEhBjP
         DisHrTMNBbYs4idMLZJ/E5wgURRcMU1VnpdlvcmYkc20Ve8BhWhP8atlAEr9RjFfz3+5
         63Gw==
X-Gm-Message-State: AOAM5302EB0H4T3gp1DNrZ8N/gvT83IHzyspEArfQWIAOnIjztPuyXVK
        DKUiIZhQcg85kvcCUc880g==
X-Google-Smtp-Source: ABdhPJxEEp/Qsw3alHt8zhmxwHRpVnbr0IilY/Bi03MDyZNTmeQPJrTz7p+nPBP14eKxCi6oX/vdRA==
X-Received: by 2002:a9d:70cc:: with SMTP id w12mr6143201otj.306.1631821755916;
        Thu, 16 Sep 2021 12:49:15 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id z7sm948074oti.65.2021.09.16.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:49:15 -0700 (PDT)
Received: (nullmailer pid 1377102 invoked by uid 1000);
        Thu, 16 Sep 2021 19:49:11 -0000
Date:   Thu, 16 Sep 2021 14:49:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Lucas Stach <dev@lynxeye.de>, linux-mmc@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Nishanth Menon <nm@ti.com>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-spi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v11 08/34] dt-bindings: host1x: Document Memory Client
 resets of Host1x, GR2D and GR3D
Message-ID: <YUOftwuVt7EqtA5I@robh.at.kernel.org>
References: <20210912200832.12312-1-digetx@gmail.com>
 <20210912200832.12312-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912200832.12312-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 12 Sep 2021 23:08:06 +0300, Dmitry Osipenko wrote:
> Memory Client should be blocked before hardware reset is asserted in order
> to prevent memory corruption and hanging of memory controller.
> 
> Document Memory Client resets of Host1x, GR2D and GR3D hardware units.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
