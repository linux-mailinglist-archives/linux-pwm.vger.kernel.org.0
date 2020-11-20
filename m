Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F398A2BAA46
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Nov 2020 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgKTMg6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Nov 2020 07:36:58 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:37640 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKTMg5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Nov 2020 07:36:57 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 6CE09C63E52;
        Fri, 20 Nov 2020 13:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605875815;
        bh=9tOCTUI7Zh2N5axz5xwyKVnUDCfX4RwFIIoyYcs6dKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNBVhPNpUNk4ZfhlX/S5GJf69/zvxTQxl8WQeTKmiMykJfkQ4D48jJPj8o8P0v1e9
         PqzyhrLp7oBgwxunuu2BhFYGWeOnTsTGJFfeQaEHjHU8FMcq5Yhv0iGqeHybNUxMbl
         yo/MFJQnRZFIs3vw9h9YV9X9nnXIRhWKVmbWItoI=
Date:   Fri, 20 Nov 2020 13:36:54 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: pca9685: Add staggered-outputs property
Message-ID: <X7e4Zj1yejjLBFyl@workstation.tuxnet>
References: <20201118174515.278067-1-clemens.gruber@pqgruber.com>
 <20201120082150.kyihkhphph7wosfz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120082150.kyihkhphph7wosfz@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Nov 20, 2020 at 09:21:50AM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 18, 2020 at 06:45:15PM +0100, Clemens Gruber wrote:
> > The pca9685 driver supports a new staggered-outputs property for reduced
> > current surges and EMI. This adds documentation for the new DT property.
> 
> Maybe point out the commit that added this support here?

The pca9685 driver patch was not yet accepted and there will be a v2.

Should I wait until the support is in Linus' tree and only then send a
dt-bindings documentation patch, mentioning the commit?

Best regards,
Clemens
