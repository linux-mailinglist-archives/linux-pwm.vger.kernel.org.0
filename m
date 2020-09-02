Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9625AADB
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBMJC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 08:09:02 -0400
Received: from smtp2.axis.com ([195.60.68.18]:29633 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBMJA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Sep 2020 08:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=353; q=dns/txt; s=axis-central1;
  t=1599048540; x=1630584540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UB9qAVvfs8T192lE6YWu3bE1bQRm/AZr6CQndih6gA8=;
  b=GjftC+hEqGe9upkSjm/YVvH0QcEd23m9xtIo8CdgThtJvdt8g74EEjOT
   S3ji/Gki8I4Jiz3XYDJiBrj/c47+OZUjg7FOM+eNgxH5kEyjhmJIHLyHT
   pBZ4y2uiPwXcSH9enwmjyAAfRZdX4/fc8erRXBrwHw9laMpdSiGAsUSL8
   HiLVkVyadaSr37Cw4HSiab6Y7bFO6U4B+deDP7THzyfptNZpEZSZ1Fk8O
   ayEZ6BE+Ub67F0jG4D9za3vjoj3jnEAreD5bT4aNrD79q6DXmBNQZ5nXz
   cHiT3j2asmNAtsHFsa1V18ol6+WZI19CnZo7jcdd0kzX9n2W+/24E4UO9
   g==;
IronPort-SDR: PGNnoDwpTx2+/YnXjlJh2GR6mqYlj2+4sc2D74qVzVml4cyj/dJyxzA9/mFJ4QTZveRoZg/QGv
 N2RayIypx1XPNfIZ9TnuiTUtZ4UFmA+71vhPsrpK3+1+DEkxCMpmDg7k/9QEtftV0JbAVGPxTS
 4ST9syPuS1lhCodHa/lIfkPSxI75sLz/qiO4uZKvLrtytfOKpktRx+J5XRKeg3doLjEuI3i0Ds
 0d0aw3m1uxB6SmK53AsCcTw1clkn0Mx6cFSRYb37JGw52IDWNYmGB7jjorJEndVDccW/+Q3M3t
 ScI=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12124115"
Date:   Wed, 2 Sep 2020 14:08:57 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "oliver@schinagl.nl" <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20200902120857.f266ogum6btq2tlq@axis.com>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200817193825.GA1416132@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200817193825.GA1416132@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 17, 2020 at 09:38:25PM +0200, Rob Herring wrote:
> On Fri, Aug 14, 2020 at 05:55:12PM +0200, Vincent Whitchurch wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pwm-gpio
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +  gpio:
> 
> 'gpios' is the preferred form even if singular.

Thanks, I've fixed this in v2.
